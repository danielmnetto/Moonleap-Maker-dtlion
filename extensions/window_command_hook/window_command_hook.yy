{
  "resourceType": "GMExtension",
  "resourceVersion": "1.2",
  "name": "window_command_hook",
  "optionsFile": "options.json",
  "options": [],
  "exportToGame": true,
  "supportedTargets": 113497714299118,
  "extensionVersion": "1.0.0",
  "packageId": "",
  "productId": "",
  "author": "",
  "date": "2019-12-12T01:34:29",
  "license": "Proprietary",
  "description": "",
  "helpfile": "",
  "iosProps": false,
  "tvosProps": false,
  "androidProps": false,
  "html5Props": false,
  "installdir": "",
  "files": [
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"window_command_hook.dll","origname":"extensions\\window_command_hook.dll","init":"","final":"","kind":1,"uncompress":false,"functions":[
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_hook_raw","externalName":"window_command_hook_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_unhook_raw","externalName":"window_command_unhook_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_check_raw","externalName":"window_command_check_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_run_raw","externalName":"window_command_run_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_get_active_raw","externalName":"window_command_get_active_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_set_active_raw","externalName":"window_command_set_active_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_get_background_redraw_raw","externalName":"window_get_background_redraw_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_set_background_redraw_raw","externalName":"window_set_background_redraw_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_get_topmost_raw","externalName":"window_get_topmost_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_set_topmost_raw","externalName":"window_set_topmost_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_get_taskbar_button_visible_raw","externalName":"window_get_taskbar_button_visible_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_set_taskbar_button_visible_raw","externalName":"window_set_taskbar_button_visible_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_set_visible_w_raw","externalName":"window_set_visible_w_raw","kind":11,"help":"","hidden":true,"returnType":2,"argCount":2,"args":[
            1,
            2,
          ],"documentation":"",},
      ],"constants":[],"ProxyFiles":[
        {"resourceType":"GMProxyFile","resourceVersion":"1.0","name":"window_command_hook_x64.dll","TargetMask":6,},
      ],"copyToTargets":9223372036854775807,"usesRunnerInterface":false,"order":[
        {"name":"window_command_hook_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_unhook_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_check_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_run_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_get_active_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_set_active_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_get_background_redraw_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_set_background_redraw_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_get_topmost_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_set_topmost_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_get_taskbar_button_visible_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_set_taskbar_button_visible_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_set_visible_w_raw","path":"extensions/window_command_hook/window_command_hook.yy",},
      ],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"window_command_hook.gml","origname":"extensions\\gml.gml","init":"window_command_hook_init","final":"","kind":2,"uncompress":false,"functions":[
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_hook_init","externalName":"window_command_hook_init","kind":11,"help":"","hidden":true,"returnType":2,"argCount":0,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_hook_prepare_buffer","externalName":"window_command_hook_prepare_buffer","kind":11,"help":"","hidden":true,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
      ],"constants":[
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_command_close","value":"$F060","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_command_maximize","value":"$F030","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_command_minimize","value":"$F020","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_command_restore","value":"$F120","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_command_resize","value":"$F000","hidden":false,},
        {"resourceType":"GMExtensionConstant","resourceVersion":"1.0","name":"window_command_move","value":"$F010","hidden":false,},
      ],"ProxyFiles":[],"copyToTargets":9223372036854775807,"usesRunnerInterface":false,"order":[
        {"name":"window_command_hook_init","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_hook_prepare_buffer","path":"extensions/window_command_hook/window_command_hook.yy",},
      ],},
    {"resourceType":"GMExtensionFile","resourceVersion":"1.0","name":"","filename":"autogen.gml","origname":"extensions\\autogen.gml","init":"","final":"","kind":2,"uncompress":false,"functions":[
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_hook","externalName":"window_command_hook","kind":2,"help":"window_command_hook(command:int)->bool","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_unhook","externalName":"window_command_unhook","kind":2,"help":"window_command_unhook(command:int)->bool","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_check","externalName":"window_command_check","kind":2,"help":"window_command_check(command:int)->bool","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_run","externalName":"window_command_run","kind":2,"help":"window_command_run(wParam:int, lParam:int = 0)->int","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_get_active","externalName":"window_command_get_active","kind":2,"help":"window_command_get_active(command:int)->int","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_command_set_active","externalName":"window_command_set_active","kind":2,"help":"window_command_set_active(command:int, value:bool)->int","hidden":false,"returnType":2,"argCount":2,"args":[
            2,
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_get_background_redraw","externalName":"window_get_background_redraw","kind":2,"help":"window_get_background_redraw()->bool","hidden":false,"returnType":2,"argCount":0,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_set_background_redraw","externalName":"window_set_background_redraw","kind":2,"help":"window_set_background_redraw(enable:bool)->bool","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_get_topmost","externalName":"window_get_topmost","kind":2,"help":"window_get_topmost()->bool","hidden":false,"returnType":2,"argCount":0,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_set_topmost","externalName":"window_set_topmost","kind":2,"help":"window_set_topmost(enable:bool)->bool","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_get_taskbar_button_visible","externalName":"window_get_taskbar_button_visible","kind":2,"help":"window_get_taskbar_button_visible()->bool","hidden":false,"returnType":2,"argCount":0,"args":[],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_set_taskbar_button_visible","externalName":"window_set_taskbar_button_visible","kind":2,"help":"window_set_taskbar_button_visible(show_button:bool)->bool","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
        {"resourceType":"GMExtensionFunction","resourceVersion":"1.0","name":"window_set_visible_w","externalName":"window_set_visible_w","kind":2,"help":"window_set_visible_w(visible:bool)->bool","hidden":false,"returnType":2,"argCount":1,"args":[
            2,
          ],"documentation":"",},
      ],"constants":[],"ProxyFiles":[],"copyToTargets":-1,"usesRunnerInterface":false,"order":[
        {"name":"window_command_unhook","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_check","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_run","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_get_active","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_command_set_active","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_get_background_redraw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_set_background_redraw","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_get_topmost","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_set_topmost","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_get_taskbar_button_visible","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_set_taskbar_button_visible","path":"extensions/window_command_hook/window_command_hook.yy",},
        {"name":"window_set_visible_w","path":"extensions/window_command_hook/window_command_hook.yy",},
      ],},
  ],
  "HTML5CodeInjection": "",
  "classname": "",
  "tvosclassname": "",
  "tvosdelegatename": "",
  "iosdelegatename": "",
  "androidclassname": "",
  "sourcedir": "",
  "androidsourcedir": "",
  "macsourcedir": "",
  "maccompilerflags": "",
  "tvosmaccompilerflags": "",
  "maclinkerflags": "",
  "tvosmaclinkerflags": "",
  "iosplistinject": "",
  "tvosplistinject": "",
  "androidinject": "",
  "androidmanifestinject": "",
  "androidactivityinject": "",
  "gradleinject": "",
  "androidcodeinjection": "",
  "hasConvertedCodeInjection": true,
  "ioscodeinjection": "",
  "tvoscodeinjection": "",
  "iosSystemFrameworkEntries": [],
  "tvosSystemFrameworkEntries": [],
  "iosThirdPartyFrameworkEntries": [],
  "tvosThirdPartyFrameworkEntries": [],
  "IncludedResources": [],
  "androidPermissions": [],
  "copyToTargets": 0,
  "iosCocoaPods": "",
  "tvosCocoaPods": "",
  "iosCocoaPodDependencies": "",
  "tvosCocoaPodDependencies": "",
  "parent": {
    "name": "Libraries",
    "path": "folders/Libraries.yy",
  },
}