from ij import IJ
from ij.gui import NewImage
from sc.fiji.snt import Tree
from sc.fiji.snt.analysis import SkeletonConverter

image = IJ.getImage()

# Create empty 16-bit image with same properies as source image
result = NewImage.createImage(
    "Merged Skeletons {}".format(image.getTitle()),
    image.getWidth(), # width
    image.getHeight(), # height
    image.getNSlices(), # depth
    16, # bit depth
    NewImage.FILL_BLACK # image contents (zero-filled)
    )
result.copyScale(image)

# Initialize SkeletonConvert. IllegalArgumentException triggered if image is not binary
converter = SkeletonConverter(image, True) # Skeletonize image in case it is not yet a skeleton?
converter.setLengthThreshold(5) # Length threshold
converter.setPruneByLength(True) # Eliminate components smaller than length threshold?
converter.setConnectComponents(True) # Merge disconnected components?
converter.setMaxConnectDist(10) # Max distance (gap size) for connection of disconnected components

# Retrieve resulting list of skeletons as Tree objects and skeletonize them
# in place in new empty image. 
for idx, tree in enumerate(converter.getTrees()): 
    tree.skeletonize(result, idx + 1) # holding image, pixel intensity of rasterized tree

# Display result
IJ.run(result, "glasbey on dark", "")
result.resetDisplayRange()
result.show()