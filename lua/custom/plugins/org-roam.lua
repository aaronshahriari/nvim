local home = os.getenv("HOME")
local function read_template(path)
  return table.concat(vim.fn.readfile(vim.fn.expand(path)), "\n")
end

return {
  "chipsenkbeil/org-roam.nvim",
  tag = "0.2.0",
  config = function()
    require("org-roam").setup({
      directory = "~/Dropbox/org/roam/",
      org_files = {
        "~/Dropbox/org/roam/daily/*.org",
        "~/Dropbox/org/roam/personal/*.org",
        "~/Dropbox/org/roam/work/*.org",
        "~/Dropbox/org/roam/recipes/*.org",
      },
      templates = {
        p = {
          description = "Personal",
          template = [[
* %? %^{TAGS}
:PROPERTIES:
:CREATED: %U
:END:
]],
          target = "%r/personal/%<%Y%m%d%H%M%S>-%[slug].org",
        },
        w = {
          description = "Work",
          template = "%?",
          target = "%r/work/%<%Y%m%d%H%M%S>-%[slug].org",
        },
      },
      extensions = {
        dailies = {
          directory = "daily",
          templates = {
            t = {
              description = "Daily",
              template = read_template(home .. "/Dropbox/org/templates/daily-template.org"),
              target = "%<%Y%m%d%H%M%S>-%[slug].org",
            },
          },
        },
      },
      ui = {
        node_buffer = {
          highlight_previews = true,
        },
      },
    })
  end
}
