import System.IO
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig (additionalKeysP)
import XMonad.Util.Run (spawnPipe)

logHook' xmobarProc = dynamicLogWithPP xmobarPP
                      { ppOutput = hPutStrLn xmobarProc
                      , ppCurrent = wrap "[" "]"
                      , ppTitle = shorten 50
                      , ppUrgent = xmobarColor "#e06c75" ""
                      }

main = do
  xmobarProc <- spawnPipe "xmobar"
  xmonad $ defaultConfig
       { modMask            = mod4Mask
       , terminal           = "st"
       , focusedBorderColor = "#4985b6"
       , normalBorderColor  = "#282c34"
       , logHook            = logHook' xmobarProc
       , handleEventHook    = docksEventHook <+> handleEventHook defaultConfig
       , layoutHook         = avoidStruts $ layoutHook defaultConfig
       }

       `additionalKeysP`
       [ ("M-b", spawn "firefox")
       , ("M-e", spawn "emacsclient -nc")
       , ("M-r", spawn "st -e ranger")
       ]
