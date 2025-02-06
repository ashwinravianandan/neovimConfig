return {
   { 'ashwinravianandan/vimProj',
   init = function()
      vim.g.project_command_hook = "BuildTags"
   end,
   keys = {{'<leader>pf', '<cmd>:call OpenProject()<CR>', desc="Open Vim project"}}
   },
   {
      'ashwinravianandan/vimNotes',
      init = function()
         vim.g.notes_directories = { '/home/ashwin/Documents/notes' }
         vim.g.notes_list_bullets = { '*', '-', '+' }
         vim.g.notes_suffix = '.md'
         vim.g.notes_unicode_enabled = 0
      end
   }
}
