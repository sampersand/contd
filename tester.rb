text = 'one1, two$ #, !2a , 4091baf !$ af #$a$g'

p text.split(/([\W])/).reject(&:empty?)