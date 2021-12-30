# ArcSystemWorksShaderMalt
A set of BlenderMalt shaders that replicate ArcSystemWorks shaders. Currently, only Guilty Gear -Strive- is supported.

The main feature of these shaders are correct outlines that account for vertex color and camera distance scaling. As a result, it is best suited to modders who wish to preview their models easily. For general purpose rendering, I suggest using Aerthas's shaders: https://github.com/Aerthas/BLENDER-Arc-System-Works-Shader.

![image](https://user-images.githubusercontent.com/9942055/147793259-dbf497f7-dba8-489d-a91c-05195286f453.png)
No mouth clipping, thanks to the blue channel of vertex color. Alpha channel vertex color is also respected.

![image](https://user-images.githubusercontent.com/9942055/147793287-e5f602a6-c58b-445c-8a94-92e4824865d0.png)
Outlines scale based on distance from camera.
