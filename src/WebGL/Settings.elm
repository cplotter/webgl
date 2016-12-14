module WebGL.Settings
    exposing
        ( Setting
          -- blend
        , blend
        , blendSeparate
        , BlendOptions
        , blendOptions
        , BlendEquation
        , add
        , subtract
        , reverseSubtract
        , BlendFactor
        , zero
        , one
        , srcColor
        , oneMinusSrcColor
        , dstColor
        , oneMinusDstColor
        , srcAlpha
        , oneMinusSrcAlpha
        , dstAlpha
        , oneMinusDstAlpha
        , constantColor
        , oneMinusConstantColor
        , constantAlpha
        , oneMinusConstantAlpha
        , srcAlphaSaturate
          -- depth
        , depth
        , DepthOptions
        , depthOptions
        , CompareMode
        , never
        , always
        , less
        , lessOrEqual
        , equal
        , greaterOrEqual
        , greater
        , notEqual
          -- stencil
        , stencil
        , stencilSeparate
        , StencilOptions
        , stencilOptions
        , ZMode
        , keep
        , none
        , replace
        , increment
        , decrement
        , invert
        , incrementWrap
        , decrementWrap
          -- others
        , scissor
        , colorMask
        , dither
        , polygonOffset
        , sampleCoverage
        , sampleAlphaToCoverage
        , cullFace
        , FaceMode
        , front
        , back
        , frontAndBack
        )

{-| # Settings

@docs Setting

# Blending

@docs blend, blendSeparate, BlendOptions, blendOptions

## Blend Factors

@docs BlendFactor, zero, one, srcColor, oneMinusSrcColor, dstColor,
      oneMinusDstColor, srcAlpha, oneMinusSrcAlpha, dstAlpha, oneMinusDstAlpha,
      constantColor, oneMinusConstantColor, constantAlpha,
      oneMinusConstantAlpha, srcAlphaSaturate

## Blend Equations

@docs BlendEquation, add, subtract, reverseSubtract

# Depth Test

@docs depth, DepthOptions, depthOptions

## Compare Modes

@docs CompareMode, never, always, less, lessOrEqual, equal, greaterOrEqual,
      greater, notEqual

# Stencil Test

In order to use this setting, `Options.stencil` has to be used in `toHtmlWith`.

@docs stencil, StencilOptions, stencilOptions, stencilSeparate

## ZModes

@docs ZMode, keep, none, replace, increment, decrement, invert,
      incrementWrap, decrementWrap

# Other settings

@docs scissor, colorMask, dither, polygonOffset, sampleCoverage,
      sampleAlphaToCoverage, cullFace

## Face Modes

@docs FaceMode, front, back, frontAndBack

-}


{-| Provides a typesafe way to configure the rendering operation in
`WebGL.renderWith`.
-}
type Setting
    = Blend BlendOptions Float Float Float Float
    | BlendSeparate BlendOptions BlendOptions Float Float Float Float
    | Depth DepthOptions
    | Stencil StencilOptions
    | StencilSeparate StencilOptions StencilOptions
    | Scissor Int Int Int Int
    | ColorMask Bool Bool Bool Bool
    | CullFace Int
    | Dither
    | PolygonOffset Float Float
    | SampleCoverage Float Bool
    | SampleAlphaToCoverage


{-| Blend setting allows to control how the source and destination
colors are blended. Initiate it with `BlendOptions` and
red, green, blue, alpha color components, that are from 0 to 1.
-}
blend : BlendOptions -> Float -> Float -> Float -> Float -> Setting
blend =
    Blend


{-| The same as blend setting, but allows to pass separate
blend options for color channels and alpha channel.
-}
blendSeparate : BlendOptions -> BlendOptions -> Float -> Float -> Float -> Float -> Setting
blendSeparate =
    BlendSeparate


{-| Defines options for the blend setting

* `equation` specifies how source and destination color components are combined,
  the default is `add`;
* `source` specifies how the source blending factors are computed, the default
  is `one`;
* `destination` specifies how the destination blending factors are computed,
  the default is `zero`.

`srcAlphaSaturate` blend factor should only be used for the source.

`constantColor` and `constantAlpha` blend factors should not be used together
for `source` and `destination`.

-}
type alias BlendOptions =
    { equation : BlendEquation
    , source : BlendFactor
    , destination : BlendFactor
    }


{-| Default options for the blend setting.
-}
blendOptions : BlendOptions
blendOptions =
    { equation = add
    , source = one
    , destination = zero
    }


{-| Allows you to define which blend factor to use.
-}
type BlendFactor
    = BlendFactor Int


{-| Multiplies all colors by 0.
-}
zero : BlendFactor
zero =
    BlendFactor 0


{-| Multiplies all colors by 1.
-}
one : BlendFactor
one =
    BlendFactor 1


{-| Multiplies all colors by the source colors.
-}
srcColor : BlendFactor
srcColor =
    BlendFactor 768


{-| Multiplies all colors by 1 minus each source color.
-}
oneMinusSrcColor : BlendFactor
oneMinusSrcColor =
    BlendFactor 769


{-| Multiplies all colors by the destination color.
-}
dstColor : BlendFactor
dstColor =
    BlendFactor 774


{-| Multiplies all colors by 1 minus each destination color.
-}
oneMinusDstColor : BlendFactor
oneMinusDstColor =
    BlendFactor 775


{-| Multiplies all colors by the source alpha value.
-}
srcAlpha : BlendFactor
srcAlpha =
    BlendFactor 770


{-| Multiplies all colors by 1 minus the source alpha value.
-}
oneMinusSrcAlpha : BlendFactor
oneMinusSrcAlpha =
    BlendFactor 771


{-| Multiplies all colors by the destination alpha value.
-}
dstAlpha : BlendFactor
dstAlpha =
    BlendFactor 772


{-| Multiplies all colors by 1 minus the destination alpha value.
-}
oneMinusDstAlpha : BlendFactor
oneMinusDstAlpha =
    BlendFactor 773


{-| Multiplies all colors by a constant color.
-}
constantColor : BlendFactor
constantColor =
    BlendFactor 32769


{-| Multiplies all colors by 1 minus a constant color.
-}
oneMinusConstantColor : BlendFactor
oneMinusConstantColor =
    BlendFactor 32770


{-| Multiplies all colors by a constant alpha value.
-}
constantAlpha : BlendFactor
constantAlpha =
    BlendFactor 32771


{-| Multiplies all colors by 1 minus a constant alpha value.
-}
oneMinusConstantAlpha : BlendFactor
oneMinusConstantAlpha =
    BlendFactor 32772


{-| Multiplies the RGB colors by the smaller of either the source alpha value
or the value of 1 minus the destination alpha value. The alpha value is
multiplied by 1.
-}
srcAlphaSaturate : BlendFactor
srcAlphaSaturate =
    BlendFactor 776


{-| Allows to specify how source and destination colors are combined.
-}
type BlendEquation
    = BlendEquation Int


{-| source + destination
-}
add : BlendEquation
add =
    BlendEquation 32774


{-| source - destination
-}
subtract : BlendEquation
subtract =
    BlendEquation 32778


{-| destination - source
-}
reverseSubtract : BlendEquation
reverseSubtract =
    BlendEquation 32779


{-| Activates depth comparisons and updates to the depth buffer.

`depth depthOptions` is included for you when you use `WebGL.render`.
-}
depth : DepthOptions -> Setting
depth =
    Depth


{-| Defines options for the depth setting:

* `func` - a function that compares incoming pixel depth to the current
  depth buffer value, the default is `less`;
* `mask` - enables the depth buffer for writing, the default is `True`;
* `near` - a mapping of the near clipping plane to window coordinates,
  [read more here](https://www.khronos.org/opengles/sdk/docs/man/xhtml/glDepthRangef.xml).
  The default is 0;
* `far` - a mapping of the far clipping plane to window coordinates, the default
  is 1.
-}
type alias DepthOptions =
    { func : CompareMode
    , mask : Bool
    , near : Float
    , far : Float
    }


{-| Default options for the depth setting.
-}
depthOptions : DepthOptions
depthOptions =
    { func = less
    , mask = True
    , near = 0
    , far = 1
    }


{-| The `CompareMode` allows you to define how to compare the incoming value
with the depth buffer value, in order to set the conditions under which
the pixel will be drawn.
-}
type CompareMode
    = CompareMode Int


{-| Never pass.
-}
never : CompareMode
never =
    CompareMode 512


{-| Always pass.
-}
always : CompareMode
always =
    CompareMode 519


{-| Pass if the incoming value is less than the depth buffer value.
-}
less : CompareMode
less =
    CompareMode 513


{-| Pass if the incoming value is less than or equal to the depth buffer value.
-}
lessOrEqual : CompareMode
lessOrEqual =
    CompareMode 515


{-| Pass if the incoming value equals the the depth buffer value.
-}
equal : CompareMode
equal =
    CompareMode 514


{-| Pass if the incoming value is greater than or equal to the depth buffer
value.
-}
greaterOrEqual : CompareMode
greaterOrEqual =
    CompareMode 518


{-| Pass if the incoming value is greater than the depth buffer value.
-}
greater : CompareMode
greater =
    CompareMode 516


{-| Pass if the incoming value is not equal to the depth buffer value.
-}
notEqual : CompareMode
notEqual =
    CompareMode 517


{-| Activates stencil testing and updates to the stencil buffer.
-}
stencil : StencilOptions -> Setting
stencil =
    Stencil


{-| Separate settings for front- and back-facing polygons.
-}
stencilSeparate : StencilOptions -> StencilOptions -> Setting
stencilSeparate =
    StencilSeparate


{-| Defines options for the stencil setting:

* `func` - the test function, the default is `always`;
* `ref` - the reference value for the stencil test, clamped to the range
  0 to 2^n - 1, n is the number of bitplanes in the stencil buffer, the
  default is 0;
* `valueMask` - bit-wise mask that is used to AND the reference value and
  the stored stencil value when the test is done, the default is all 1's;
* `fail` - the function to use when the stencil test fails, the default
  is `keep`;
* `zfail` - the function to use when the stencil test passes, but the depth
  test fails, the default is `keep`;
* `zpass` - the function to use when both the stencil test and the depth test
  pass, or when the stencil test passes and there is no depth buffer or depth
  testing is disabled, the default is `keep`;
* `writeMask` - a bit mask to enable or disable writing of individual bits in
  the stencil plane, the default is all 1's.
-}
type alias StencilOptions =
    { func : CompareMode
    , ref : Int
    , valueMask : Int
    , fail : ZMode
    , zfail : ZMode
    , zpass : ZMode
    , writeMask : Int
    }


{-| Defaut options for the stencil setting.
-}
stencilOptions : StencilOptions
stencilOptions =
    { func = always
    , ref = 0
    , valueMask = 4294967295
    , fail = keep
    , zfail = keep
    , zpass = keep
    , writeMask = 4294967295
    }


{-| The `ZMode` type allows you to define what to do with the stencil buffer
value.
-}
type ZMode
    = ZMode Int


{-| Keeps the current value.
-}
keep : ZMode
keep =
    ZMode 7680


{-| Sets the stencil buffer value to 0. Should've been named `zero`,
according to specification, but it was taken.
-}
none : ZMode
none =
    ZMode 0


{-| Sets the stencil buffer value to `ref` from the `stencilOptions`.
-}
replace : ZMode
replace =
    ZMode 7681


{-| Increments the current stencil buffer value. Clamps to the maximum
representable unsigned value.
-}
increment : ZMode
increment =
    ZMode 7682


{-| Decrements the current stencil buffer value. Clamps to 0.
-}
decrement : ZMode
decrement =
    ZMode 7683


{-| Bitwise inverts the current stencil buffer value.
-}
invert : ZMode
invert =
    ZMode 5386


{-| Increments the current stencil buffer value. Wraps stencil buffer value to
zero when incrementing the maximum representable unsigned value.
-}
incrementWrap : ZMode
incrementWrap =
    ZMode 34055


{-| Decrements the current stencil buffer value.
Wraps stencil buffer value to the maximum representable unsigned
value when decrementing a stencil buffer value of zero.
-}
decrementWrap : ZMode
decrementWrap =
    ZMode 34056


{-| Set the scissor box, which limits the drawing of fragments to the
screen to a specified rectangle.

The arguments are the coordinates of the lower left corner, width and height.

-}
scissor : Int -> Int -> Int -> Int -> Setting
scissor =
    Scissor


{-| Specify whether or not each channel (red, green, blue, alpha)
should be written into the frame buffer.
-}
colorMask : Bool -> Bool -> Bool -> Bool -> Setting
colorMask =
    ColorMask


{-| Dither color components or indices before they
are written to the color buffer.
-}
dither : Setting
dither =
    Dither


{-| Add an offset to depth values of a polygon's fragments produced by
rasterization. The offset is added before the depth test is performed and
before the value is written into the depth buffer.

* the first argument is the scale factor for the variable depth offset for
  each polygon;
* the second argument is the multiplier by which an implementation-specific
  value is multiplied
  with to create a constant depth offset.
-}
polygonOffset : Float -> Float -> Setting
polygonOffset =
    PolygonOffset


{-| Specify multisample coverage parameters.

The fragment's coverage is ANDed with the temporary coverage value.

* the first argument specifies sample coverage value, that is clamped to
  the range 0 1;
* the second argument represents if the coverage masks should be inverted.
-}
sampleCoverage : Float -> Bool -> Setting
sampleCoverage =
    SampleCoverage


{-| Compute a temporary coverage value, where each bit is determined by the
alpha value at the corresponding sample location.

The temporary coverage value is then ANDed with the fragment coverage value.
-}
sampleAlphaToCoverage : Setting
sampleAlphaToCoverage =
    SampleAlphaToCoverage


{-| Excludes polygons based on winding (the order of the vertices) in window
coordinates. Polygons with counter-clock-wise winding are front-facing.
-}
cullFace : FaceMode -> Setting
cullFace (FaceMode faceMode) =
    CullFace faceMode


{-| The `FaceMode` defines the face of the polygon.
-}
type FaceMode
    = FaceMode Int


{-| Targets the front-facing polygons.
-}
front : FaceMode
front =
    FaceMode 1028


{-| Targets the back-facing polygons.
-}
back : FaceMode
back =
    FaceMode 1029


{-| Targets both front- and back-facing polygons.
-}
frontAndBack : FaceMode
frontAndBack =
    FaceMode 1032