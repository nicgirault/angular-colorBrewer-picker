angular-colorBrewer-selector
============================

An Angular stand-alone module to select a [color Brewer](http://colorbrewer2.org/) palette.

Demo: [http://jsfiddle.net/nicgirault/bqph3pkL/](http://jsfiddle.net/nicgirault/bqph3pkL/)

Two directives can be used:

```
<color-brewer-picker-select
  cb-initial-palette-name='{{ paletteName }}'
  cb-size='{{ size }}'
  cb-initial-range='{{ range }}'
  cb-picker-callback='callback(paletteName, range, palette)'
/>
```

```
<color-brewer-palette
  cb-palette-name='{{ name }}'
  cb-horizontal='{{ true }}'
  cb-size='{{ size }}'
  cb-range='{{ range }}'
  cb-reverse='{{ isReverse }}'
/>
```

TODO:
-----
- Add isReverse in callback
- Debug reverse behavior before selecting a range
- Improve css

If you think you're able to do one of these things, please contact me.

Feedbacks are more than welcome
-------------------------------
nic.girault+colorBrewer@gmail.com
