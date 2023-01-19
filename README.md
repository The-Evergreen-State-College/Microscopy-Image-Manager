# Microscopy-Image-Manager

## Description

Microscopy Image Manager (MIM) is an automated program that takes images taken during a session and does 2 things:

(1)	Moves images from “Current Session” folder to “Previous Sessions” on the local computer;

(2)	Archive compresses the “Current Session” folder and ships it to a network file share:

`SET NETWORK_FILE_SHARE=`

`SET NETWORK_FILE_SHARE=<server>\<share>`


*where <Microscope> is the make and model.
**Package naming convention: <ISODate8601>_<UserName>.7z


### Dependencies

Depends on [7-Zip](https://www.7-zip.org/) to create an archive compressed image package. 