# QB64 themes
This repository is a compilation of themes and stuff for [QB64](https://github.com/qb64team/qb64). Pretty straightfoward.

## Installing themes
To install themes, go to your config.ini file, found in the internal directory. In the section "IDE COLOR SCHEMES", append it with `Scheme<number>$=(QBT file contents)`, for example:

```ini
[IDE COLOR SCHEMES]
Instructions1="Create custom color schemes in the IDE (Options->IDE Colors)."
Instructions2="Custom color schemes will be stored in this section."
Scheme1$=Night Coder|226226226039157000245128177137137137177196000196118000000000000049049049098098098
Scheme2$=High Contrast Light|000000000000000108245000000137000039000088000098137088255255255245255088000147177
Scheme3$=High Contrast Dark|255255255000157255245049078206177000000255000255078245000000000020020029000147147
...
```

If you do not have this section, don't worry, it's completely normal. Simply copy and paste [template.ini](https://github.com/all-other-usernames-were-taken/QB64-Themes/blob/main/template.ini) under the "IDE DISPLAY SETTINGS" category of your config.ini file.