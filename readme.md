# TinyMCE v4 toolbar and menubar control identifier constants

This is a simple package that contains TinyMCE v4 toolbar and menubar control identifiers. It also contains constants for the plugins that have menu and/or toolbar control.

Constant values are extracted from the TinyMCe web page: https://www.tinymce.com/docs/advanced/editor-control-identifiers/

See Scripts folder how the values are scraped from the web page and how the constant class files are generated.

# Install with NuGet Package Manager

Add my public MyGet feed to Visual Studio package sources:
- NuGet v3 (VS2015+): `https://www.myget.org/F/swapcode-episerver/api/v3/index.json`
- NuGet v2 (VS2012+): `https://www.myget.org/F/swapcode-episerver/api/v2`

Install using package manager UI in Visual Studio or in Package Manager Console:
`Install-Package Swapcode.TinyMce.Constants -Version 1.0.0 -Source https://www.myget.org/F/swapcode-episerver/api/v3/index.json`

MyGet: [Swapcode.TinyMce.Constants](https://www.myget.org/feed/swapcode-episerver/package/nuget/Swapcode.TinyMce.Constants)

You can also download the NuGet package from the [releases](https://github.com/alasvant/Swapcode.TinyMce.Constants/releases).
