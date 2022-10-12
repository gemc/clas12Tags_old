

def get_gcards(dir_path):
    """
    Parse the list of files with extension .gcard inside path dir_path
    Remove extension .gcard from the file names
    Return the list of file names
    """
    import os
    gcard_list = []
    dpath = dir_path + "/"
    for file in os.listdir(dpath):
        if file.endswith(".gcard"):
            gcard_list.append(file[:-6])
    return gcard_list




def rename_gcards(dir_path):
    """
    Rename the files in gcard_list with extension .gcard
    If the filename contains '_txtField' then remove it
    Otherwise add _binaryField to the filename
    Log each rename operation with git mv command
    """
    import os
    gcard_list = get_gcards(dir_path)
    dpath = dir_path + "/"
    for file in gcard_list:
        if "_txtField" in file:
            new_file = file.replace("_txtField", "")
           # os.rename(dpath + file + ".gcard", dpath + new_file + ".gcard")
            print("git mv " + file + ".gcard " + new_file + ".gcard")
        else:
            new_file = file + "_binaryField"
            # os.rename(dpath + file + ".gcard", dpath + new_file + ".gcard")
            print("git mv " + file + ".gcard " + new_file + ".gcard")





if __name__ == "__main__":
    import sys
    dir_path = sys.argv[1]
    rename_gcards(dir_path)




