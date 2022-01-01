# ArcSystemWorksShaderMalt
A set of BlenderMalt shaders that replicate ArcSystemWorks shaders. All released 3D ArcSys games are supported.

BlenderMalt is obviously required to use this. Get it from here: https://github.com/bnpr/Malt/

The main feature of these shaders are correct outlines that account for vertex color and camera distance scaling. As a result, it is best suited to modders who wish to preview their models easily. For general purpose rendering, I suggest using Aerthas's shaders: https://github.com/Aerthas/BLENDER-Arc-System-Works-Shader.

Do not use a solidify modifier to generate outlines. Copy the meshes that you wish to put an outline on and set it to use the MI_MAIN_OUTLINE material. Set all models that have outlines to double sided.

For decal materials, check the transparency box, or else it will not work.
