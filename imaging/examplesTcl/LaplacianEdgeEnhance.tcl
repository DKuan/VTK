catch {load vtktcl}
# This script subtracts the 2D laplacian from an image to enhance the edges.


source vtkImageInclude.tcl

# Image pipeline

vtkImageReader reader
#reader DebugOn
[reader GetCache] ReleaseDataFlagOff
reader SetDataByteOrderToLittleEndian
reader SetDataExtent 0 255 0 255 1 93
reader SetFilePrefix "../../../vtkdata/fullHead/headsq"
reader SetDataMask 0x7fff

vtkImageCast cast
cast SetInput [reader GetOutput]
cast SetOutputScalarTypeToFloat

vtkImageLaplacian lap
lap SetInput [cast GetOutput]
lap SetDimensionality 2

vtkImageMathematics subtract
subtract SetOperationToSubtract
subtract SetInput1 [cast GetOutput]
subtract SetInput2 [lap GetOutput]
subtract ReleaseDataFlagOff
#subtract BypassOn

vtkImageViewer viewer
#viewer DebugOn
viewer SetInput [subtract GetOutput]
viewer SetZSlice 22
viewer SetColorWindow 2000
viewer SetColorLevel 1000


# make interface
source WindowLevelInterface.tcl





