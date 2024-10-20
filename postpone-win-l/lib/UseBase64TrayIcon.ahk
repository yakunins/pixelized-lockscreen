#Requires AutoHotkey v2.0
#include ImagePut.ahk

; embed tray icons as base64 string into AHK script
UseBase64TrayIcon(name := "transparent", debug := false) {
	icons := {
		postpone: "iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAA3ZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDkuMS1jMDAyIDc5LmE2YTYzOTY4YSwgMjAyNC8wMy8wNi0xMTo1MjowNSAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOk9yaWdpbmFsRG9jdW1lbnRJRD0ieG1wLmRpZDpkZGUzZTkxZi1jMmEyLTJhNDItYTUwNS0yNmY2MzZkNDE1NjkiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6M0U5OTRFQTc4QUFGMTFFRjg5NzBDMEZBMkMzOTk3ODIiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6M0U5OTRFQTY4QUFGMTFFRjg5NzBDMEZBMkMzOTk3ODIiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIDI1LjkgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6OGQ0NmY2MmEtZmNlNS1iNDQ2LTg3ODItMDJhNWI5ODRiZTdlIiBzdFJlZjpkb2N1bWVudElEPSJ4bXAuZGlkOmRkZTNlOTFmLWMyYTItMmE0Mi1hNTA1LTI2ZjYzNmQ0MTU2OSIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/Pqb7bxcAAACCSURBVHjaYvz//z8DJYAFm+CcOXOqgVQylDs3JSWlFZcBTDg0OwNxLBQ7Q8WQ1SCcDfICMp49e/Z/UsQYgQyQ6S04XFgDcj6KjeiAUhcwkRPyIBcBXcYIYjPCohEaUC0E9NZgxAg+ZxLjFSYGCsGoAaiZqQZvioOqQRdgpDQ7AwQYALAPuWYLJ4x+AAAAAElFTkSuQmCC",
		transparent: "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABAQMAAAAl21bKAAAAA1BMVEUAAACnej3aAAAAAXRSTlMAQObYZgAAAApJREFUCNdjYAAAAAIAAeIhvDMAAAAASUVORK5CYII=",
	}

	if icons.HasOwnProp(name) {
		iconHandler := Base64ToIcon(icons.%name%, debug)
		if (iconHandler) {
			e := false
			try {
				TraySetIcon("HICON:*" hICON := iconHandler)
			} catch Error as e {
				if (debug)
					MsgBox e.message
			}
		}
	}
}

Base64ToIcon(base64string, debug := false) {
	try {
		iconHandler := ImagePutHIcon({ image: CleanBase64(base64string) })
	} catch Error as e {
		if (debug)
			MsgBox e.message
		return false
	}

	return iconHandler
}

CleanBase64(b64str) {
	if InStr(b64str, ",") {
		parts := StrSplit(b64str, ",", 2)
		if parts.Length == 2 and InStr(parts[1], "data") and StrLen(parts[2]) > 2
			return parts[2]
	}
	return b64str
}