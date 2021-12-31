# ArcSystemWorksShaderMalt
A set of BlenderMalt shaders that replicate ArcSystemWorks shaders. All released 3D ArcSys games are supported.

BlenderMalt is obviously required to use this. Get it from here: https://github.com/bnpr/Malt/

The main feature of these shaders are correct outlines that account for vertex color and camera distance scaling. As a result, it is best suited to modders who wish to preview their models easily. For general purpose rendering, I suggest using Aerthas's shaders: https://github.com/Aerthas/BLENDER-Arc-System-Works-Shader.

Do not use a solidify modifier to generate outlines. Copy the meshes that you wish to put an outline on and set it to use the MI_MAIN_OUTLINE material.

![image](https://user-images.githubusercontent.com/9942055/147793259-dbf497f7-dba8-489d-a91c-05195286f453.png)
No mouth clipping, thanks to the blue channel of vertex color. Alpha channel vertex color is also respected.

![image](https://user-images.githubusercontent.com/9942055/147793287-e5f602a6-c58b-445c-8a94-92e4824865d0.png)
Outlines scale based on distance from camera.

![image](https://user-images.githubusercontent.com/9942055/147793354-dc9bb03c-8d6f-42e7-828d-3eb3fded4a0e.png)
![image](https://user-images.githubusercontent.com/9942055/147793396-1649e054-4322-4e2f-b176-d0fcd8c5d4ac.png)
Outline width is customizable without the need for modifiers.

![image](https://user-images.githubusercontent.com/9942055/147797204-7e771b6c-132b-4b93-98fa-5db6afd680a5.png)
Xrd
![image](https://user-images.githubusercontent.com/9942055/147797224-7400dd99-ffe6-40ff-84ee-9336dd81f190.png)
FighterZ
![image](https://user-images.githubusercontent.com/9942055/147797235-d3e3af4c-3a53-4d93-93fc-f48f963f05f6.png)
Granblue
![image](https://user-images.githubusercontent.com/9942055/147797197-32408340-15f0-426e-b748-83a267a7c143.png)
Strive
