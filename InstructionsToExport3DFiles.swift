//How to export character animation from Maya, to Mixamo, to Xcode:
/*
 Scale character to 1.5m with the scene configured to Meters. Then, convert the scene to Centimeters. Then, export T-Stance character in .obj for use in Mixamo. In Mixamo, download rigged T-Stance to use in the future to properly export hair.
 
 Download the desired animation at 60FPS in .fbx with skin definition. Then, import to scene in Maya configured in Meters. Add one Lambert Material to head called "faceMaterial" and one lambert Material to body called "bodyMaterial".
 
 The name of the head mesh must be "head". The name of the body mesh must be "body". Head, face and the rig must be grouped under the name "character". Then, export as .dae file with Axis conversion to Z, bake animations, and skin definition.
 
 Import to Xcode. Change group name. Save Xcode file. Then undo the name change. Save again. Open file in finder. Run the "ConvertToXcodeCollada" script. Delete the dae-e file.
 */

//How to export a hair mesh from Maya to Xcode:
/*
 First position hair on top of a rigged T-Stance character. Then, edit pivot. Turn on snap to point tool and snap pivot to the mixamorig_Head bone. Rotate y axis to point at mixamorig_HeadTop_End. Delete rigged T-Stance character, leaving only hair. Turn off snap to point tool and turn on snap to grid. Move hair until pivot is on 0,0,0. Delete history and freeze transformations. Export as DAE with Axis conversion to Z. Import to Xcode. Change Local Euler X rotation coordinates from 90 to 0.
 */

//Hair naming convention:
/*
 The .dae file should always be started with "hair_", followed by length ("cropped", "short", "medium", "long") and then a quirky adjective or name (for example, "boyish", "pigtail", "mohawk"). The name of the mesh should always be "hair".
 */
