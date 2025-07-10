#!/usr/bin/env fish

set dwl_path "$HOME/repos/dwl"
set dwl_dotfile "$HOME/repos/dotfiles/dwl"
set dwl_patch_dir "$dwl_dotfile/patch"

function update_patch -a fin fout
	set pre_patch_file "$dwl_path/$fin.orig"
	set post_patch_file "$dwl_path/$fin"
	diff $pre_patch_file $post_patch_file > "$dwl_patch_dir/$fout"
end

update_patch 'config.h' 'diff-config.patch'
update_patch 'config.mk' 'diff-configmk.patch'
update_patch 'dwl.desktop' 'diff-desktop.patch'
