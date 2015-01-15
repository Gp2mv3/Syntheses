COURSE=math
QUADRI=3
ifeq ($(TYPE),exam)
  include ../../../../../root.mk
else
  include ../../../root.mk
endif
