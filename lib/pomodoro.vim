" Duration of a pomodoro in minutes (default: 25)
let g:pomodoro_time_work = 25

" Duration of a break in minutes (default: 5)
let g:pomodoro_time_slack = 5

" Log completed pomodoros, 0 = False, 1 = True (default: 0)
let g:pomodoro_do_log = 0

" Path to the pomodoro log file (default: /tmp/pomodoro.log)
let g:pomodoro_log_file = "~/.pomodoro.log"

let g:pomodoro_notification_cmd = 'zenity --notification --text="Pomodoro finished"'


if !exists('g:lightline')
	let g:lightline = {}
endif
if !exists('g:lightline.component')
	let g:lightline.component = {}
endif
if !exists('g:lightline.component_visible_condition')
	let g:lightline.component_visible_condition = {}
endif
let g:lightline.active.left[2] += [ 'pomodoro' ]
let g:lightline.component["pomodoro"] = '%{pomo#status_bar()}'
let g:lightline.component_visible_condition["pomodoro"] = '(!empty(pomo#status_bar()))'

