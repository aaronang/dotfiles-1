 -- referenced from 
 -- https://github.com/andrusha/dotfiles/blob/master/.xmonad/xmonad.hs
import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
-- import XMonad.Layout.NoBorders
-- import XMonad.Layout.Gaps -- try to not use this
import System.IO

main = do
    xmproc <- spawnPipe "xmobar"
    -- spawn myTrayer
    -- spawn myDropbox
    xmonad $ defaultConfig
        {
        layoutHook=avoidStruts $ layoutHook defaultConfig
        , manageHook=manageHook defaultConfig <+> manageDocks
        -- manageHook = manageDocks <+> manageHook defaultConfig
        -- , layoutHook = avoidStruts  $  layoutHook defaultConfig
        -- , layoutHook = gaps [(U,17)] $ Tall 1 (3/100) (1/2) ||| Full
        -- , layoutHook = smartBorders $ layoutHook defaultConfig
        , logHook = dynamicLogWithPP xmobarPP
                        { ppOutput = hPutStrLn xmproc
                        , ppTitle = xmobarColor "green" "" . shorten 50
                        }
        , modMask = myModMask
        , terminal = myTerminal
        , focusedBorderColor = myBorderColor
        , borderWidth = myBorderWidth
        , workspaces = myWorkspaces
        }

        `additionalKeys`
        [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock")
        , ((controlMask, xK_Print), spawn "sleep 0.2; scrot -s")
        , ((0, xK_Print), spawn "scrot")
        ]


myTerminal = "terminator"
myBorderColor = "#00cc00"
myBorderWidth = 1
myModMask = mod4Mask -- Rebind Mod to the Windows key

-- Spawned processes
-- myTrayer = "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 10 --transparent true --tint 0x000000 --height 12 "
-- myDropbox = "if [ ! \"$(pidof dropbox)\" ] ; then dropboxd ; fi"

-- Workspaces
myWorkspaces = ["main", "code", "web", "chat"] ++ map show [5..9]
