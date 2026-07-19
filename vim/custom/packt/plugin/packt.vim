vim9script

# fnameescape
# fnamemodify
# glob
# glob2regpat
# globpath
# expand
# isdirectory
# mkdir
# readdir
# readdirex
# rename

def ListAllPackageGroups(): list<string>
	const packdirs = &rtp

	const pkgs = globpath(packdirs, "pack/*", 0, 1)

	return pkgs
enddef

def ListAllPackagePlugins(): list<string>
	const packdirs = &rtp

	const pkgs = globpath(packdirs, "pack/*/*/*", 0, 1)

	const pkgnames = mapnew(pkgs, (key, val) => {
		var parts = reverse(split(val, '/'))
		var pluginname = parts[0]
		var packtype = parts[1]
		var groupname = parts[2]
		return join([groupname, packtype, pluginname], '/')
	})

	return pkgnames
enddef

def ListAllPackagePluginNames(): list<string>
	const packdirs = &rtp

	const pkgs = globpath(packdirs, "pack/*/*/*", 0, 1)

	const pkgnames = mapnew(pkgs, (key, val) => fnamemodify(val, ":t"))

	return pkgnames
enddef

def ListAllPackageStartPlugins(): list<string>
	const packdirs = &rtp

	const pkgs = globpath(packdirs, "pack/*/start/*", 0, 1)

	return pkgs
enddef

def ListAllPackageOptPlugins(): list<string>
	const packdirs = &rtp

	const pkgs = globpath(packdirs, "pack/*/opt/*", 0, 1)

	return pkgs
enddef

nnoremap <Leader>k <ScriptCmd>echo ListAllPackagePlugins()<CR>
