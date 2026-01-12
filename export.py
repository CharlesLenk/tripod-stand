from scad_export.export import export
from scad_export.exportable import Folder, Model

files=Folder(
    name='scad_export/tripod_stand',
    contents=[Model(name='tripod_stand', width=width) for width in range(50, 81, 15)]
)

export(files)
