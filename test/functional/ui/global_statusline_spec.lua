local helpers = require('test.functional.helpers')(after_each)
local Screen = require('test.functional.ui.screen')
local clear, command, feed = helpers.clear, helpers.command, helpers.feed

describe('global statusline', function()
  local screen

  before_each(function()
    clear()
    screen = Screen.new(60, 16)
    screen:attach()
    command('set laststatus=3')
    command('set ruler')
  end)

  it('works', function()
    screen:expect{grid=[[
      ^                                                            |
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {2:[No Name]                                 0,0-1          All}|
                                                                  |
    ]], attr_ids={
      [1] = {bold = true, foreground = Screen.colors.Blue1};
      [2] = {bold = true, reverse = true};
    }}

    feed('i<CR><CR>')
    screen:expect{grid=[[
                                                                  |
                                                                  |
      ^                                                            |
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {2:[No Name] [+]                             3,1            All}|
      {3:-- INSERT --}                                                |
    ]], attr_ids={
      [1] = {bold = true, foreground = Screen.colors.Blue};
      [2] = {bold = true, reverse = true};
      [3] = {bold = true};
    }}
  end)

  it('works with splits', function()
    command('vsplit | split | vsplit | vsplit | wincmd l | split | 2wincmd l | split')
    screen:expect{grid=[[
                          {1:│}                {1:│} {1:│}^                    |
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:├────────────────┤}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}                {1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:├────────────────────}|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}                    |
      {1:────────────────────┴────────────────┴─┤}{2:~                   }|
                                             {1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {3:[No Name]                                 0,0-1          All}|
                                                                  |
    ]], attr_ids={
      [1] = {reverse = true};
      [2] = {bold = true, foreground = Screen.colors.Blue1};
      [3] = {bold = true, reverse = true};
    }}
  end)

  it('works when switching between values of laststatus', function()
    command('set laststatus=1')
    screen:expect{grid=[[
      ^                                                            |
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
                                                0,0-1         All |
    ]], attr_ids={
      [1] = {foreground = Screen.colors.Blue, bold = true};
    }}

    command('set laststatus=3')
    screen:expect{grid=[[
      ^                                                            |
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {1:~                                                           }|
      {2:[No Name]                                 0,0-1          All}|
                                                                  |
    ]], attr_ids={
      [1] = {foreground = Screen.colors.Blue, bold = true};
      [2] = {reverse = true, bold = true};
    }}

    command('vsplit | split | vsplit | vsplit | wincmd l | split | 2wincmd l | split')
    command('set laststatus=2')
    screen:expect{grid=[[
                          {1:│}                {1:│} {1:│}^                    |
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│< Name] 0,0-1   │}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}                {1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{3:<No Name] 0,0-1  All}|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}                    |
      {1:<No Name] 0,0-1  All < Name] 0,0-1    <│}{2:~                   }|
                                             {1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {1:[No Name]            0,0-1          All <No Name] 0,0-1  All}|
                                                                  |
    ]], attr_ids={
      [1] = {reverse = true};
      [2] = {foreground = Screen.colors.Blue, bold = true};
      [3] = {reverse = true, bold = true};
    }}

    command('set laststatus=3')
    screen:expect{grid=[[
                          {1:│}                {1:│} {1:│}^                    |
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:├────────────────┤}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}                {1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:├────────────────────}|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}                    |
      {1:────────────────────┴────────────────┴─┤}{2:~                   }|
                                             {1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {3:[No Name]                                 0,0-1          All}|
                                                                  |
    ]], attr_ids={
      [1] = {reverse = true};
      [2] = {foreground = Screen.colors.Blue, bold = true};
      [3] = {reverse = true, bold = true};
    }}

    command('set laststatus=0')
    screen:expect{grid=[[
                          {1:│}                {1:│} {1:│}^                    |
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│< Name] 0,0-1   │}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}                {1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{3:<No Name] 0,0-1  All}|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}                    |
      {1:<No Name] 0,0-1  All < Name] 0,0-1    <│}{2:~                   }|
                                             {1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
                                                0,0-1         All |
    ]], attr_ids={
      [1] = {reverse = true};
      [2] = {foreground = Screen.colors.Blue, bold = true};
      [3] = {reverse = true, bold = true};
    }}

    command('set laststatus=3')
    screen:expect{grid=[[
                          {1:│}                {1:│} {1:│}^                    |
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:├────────────────┤}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}                {1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}{2:~                   }|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:├────────────────────}|
      {2:~                   }{1:│}{2:~               }{1:│}{2:~}{1:│}                    |
      {1:────────────────────┴────────────────┴─┤}{2:~                   }|
                                             {1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {2:~                                      }{1:│}{2:~                   }|
      {3:[No Name]                                 0,0-1          All}|
                                                                  |
    ]], attr_ids={
      [1] = {reverse = true};
      [2] = {foreground = Screen.colors.Blue, bold = true};
      [3] = {reverse = true, bold = true};
    }}
  end)
end)
