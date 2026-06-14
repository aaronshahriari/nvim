return function()
  vim.pack.add({
    { src = "https://github.com/arminveres/md-pdf.nvim" },
  })
  require('md-pdf').setup({
    --- Set margins around document
    margins = "1.5cm",
    -- tango, pygments are quite nice for white on white
    highlight = "tango",
    -- Generate a table of contents, on by default
    toc = true,
    -- Render a dedicated title page (and keep ToC on a separate page)
    title_page = false,
    -- No-op: the keymap below opens zathura itself, because the plugin skips
    -- its viewer step whenever the engine writes anything to stderr.
    preview_cmd = function() return "true" end,
    -- if true, then the markdown file is continuously converted on each write, even if the
    -- file viewer closed, e.g., Firefox is "closed" once the document is opened in it.
    ignore_viewer_state = false,
    -- Specify font, `nil` uses the default font of the theme
    fonts = {
      main_font = nil,
      sans_font = nil,
      mono_font = "CaskaydiaCove Nerd Font Mono",
      math_font = nil,
    },
    --- Path to output. Needs to be always relative, e.g.: "./", "../", "./out" or simply "out", but
    --- not absolute e.g.: "/"! Up a dir into ../pdf/ so PDFs don't clutter the notes dir.
    output_path = "../pdf/",
    -- PDF converter engine. typst (not LaTeX): it renders raw markdown prose
    -- as-is, so stray backslash sequences like `\n` in notes don't blow up the
    -- build the way an undefined LaTeX control sequence does. No stderr-filter
    -- wrapper needed — typst is quiet on success.
    pdf_engine = "typst",
  })

  -- Just convert; no auto-open. Open the resulting PDF from oil with <space>z
  -- (see oil.lua). The PDF lands one dir up in ../pdf/ per output_path above.
  vim.keymap.set("n", "<Space>,", function()
    local dir = vim.fn.expand("%:p:h")
    -- md-pdf won't create the output dir, so ensure it exists before converting.
    vim.fn.mkdir(vim.fs.normalize(dir .. "/../pdf"), "p")
    require('md-pdf').convert_md_to_pdf()
  end)
end
