1. main.m is the main script. 
    input_dir = path of the input image directory. 
    output_dir = path of the directory where centers are strored. 

2. cluster.m is used for merging nearby peaks.
    Input: Cell centers
    Output: Merged Nearby Peaks

3. edge_layers is the function to find the different edge layers (IEC and OBC)
    Input: Significant Map, centers and attenuated DT map
    Output: Inner Edge Contours (IEC) and Outer Boundary Contours (OBC)

4. evaluate.m is the main algorithm function. 
    Input: DHS 