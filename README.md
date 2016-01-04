toggl.vim
=========

Toggl client for vimscript and vim.

Usage
-----
Set your [API token](https://github.com/toggl/toggl_api_docs#api-token)

```vim
let g:toggl_api_token = "b51ff78xxxxxxxxxxxxxxxxxxxxxxxxx"
```

Start task

```vim
:TogglStart task name +project @tag1 @tag2
```

Stop current task

```vim
:TogglStop
```

unite.vim interface
--------------------

There are two sources:

```vim
:Unite toggl/task
```

which helps you to restart past time entries.

```vim
:Unite toggl/project
```

which helps you to change the project of current task.


License
-------
MIT (see LICENSE file)
