noremap <leader>r :<C-u>VimuxRunCommand 'cargo run'<cr>
noremap <leader>b :<C-u>VimuxRunCommand 'cargo build'<cr>
noremap <leader>c :<C-u>VimuxRunCommand 'cargo check'<cr>
noremap <leader>z :<C-u>VimuxRunCommand 'cargo test'<cr>

let b:ale_rust_rls_toolchain = 'stable'
let b:ale_rust_cargo_use_check = 1
let b:ale_rust_cargo_check_all_targets = 1

let g:rustfmt_command = "rustfmt"
let g:rustfmt_autosave = 1
let g:rustfmt_emit_files = 1
let g:rustfmt_fail_silently = 0
let g:rust_clip_command = 'xclip -selection clipboard'

let $RUST_SRC_PATH = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"
