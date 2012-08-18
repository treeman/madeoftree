---
layout: wiki
---

Make minecraft respect window resizing.

    import XMonad.Hooks.SetWMName

    main = do
            xmonad $ defaultConfig
            { modMask = mod4Mask
            , startupHook = setWMName "LG3D"
            -- other customizations
            }

