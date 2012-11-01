;---------------------------------------
; CLi (Command Line Interface) API Header
;---------------------------------------
deviceSDZC	equ	#00			; SD-Card Z-Controller (SDZC)
deviceNemoM	equ	#01			; Nemo IDE Master
deviceNemoS	equ	#02			; Nemo IDE Slave

flagFile	equ	#00			; flag:#00 - file
flagDir		equ	#10			;      #10 - dir

resPal		equ	#01			; ресурс палитра
resSpr		equ	#02			; ресурс спрайты
;---------------------------------------
shellStart	jp	_shellStart		; Начальна точка входа в CLi
						; i:A - тип вызова:
						;   #00 - вызов по расширению
						;   #03 - вызов из меню запуска плагинов
						;   любые другие значения - выход
						; o:A - статус:
						;   #00 - ошибок нет
						;   #01 - файл не опознан, пусть забирают вьюверы/другой плагин

openStream	jp	_openStream		; окрываем 0-й поток с устройством
						; i:B - устройство:
						;	deviceSDZC - SD-Card Z-Controller (SDZC)
						;	deviceNemoM - Nemo IDE Master
						;	deviceNemoS -Nemo IDE Slave
						;   C - раздел (не учитывается)
						;   BC=#FFFF: включает 0-й поток (не возвращает флагов)
						;	      иначе создает/пересоздает поток.
						; o:NZ - устройство или раздел не найдены
						;   Z - можно начинать работать с потоком

pathToRoot	jp	_pathToRoot		; сброс Path текущего устройства (0-й поток) в root /
						; i: входящих параметров не требуется
						; o: на выходе так же нет флагов

checkKeyEnter	jp	_checkKeyEnter		; опрос статуса клавиши Enter
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyDel	jp	_checkKeyDel		; опрос статуса клавиши Delete
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyUp	jp	_checkKeyUp		; опрос статуса клавиши курсор вверх
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyDown	jp	_checkKeyDown		; опрос статуса клавиши курсор вниз
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyLeft	jp	_checkKeyLeft		; опрос статуса клавиши курсор влево
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyRight	jp	_checkKeyRight		; опрос статуса клавиши курсор вправо
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyAlt	jp	_checkKeyAlt		; опрос статуса клавиши Alt
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyEsc	jp	_checkKeyEsc		; опрос статуса клавиши Esc
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyF1	jp	_checkKeyF1		; опрос статуса клавиши F1
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

checkKeyF2	jp	_checkKeyF2		; опрос статуса клавиши F2
						; i: входящих параметров не требуется
						; o:NZ - клавиша нажата
						;   Z - ошибка или клавиша не была нажата

waitKeyCalm	jp	_waitKeyCalm		; ожидание готовности клавиатуры
						; рекомендуется использовать перед вызовом «waitAnyKey»
						; i: входящих параметров не требуется
						; o: на выходе так же нет флагов

waitAnyKey	jp	_waitAnyKey		; ожидание нажатия любой клавиши (Any Key)
						; i: входящих параметров не требуется
						; o: на выходе так же нет флагов

getKey		jp	_getKey			; опрос клавиатуры
						; i: входящих параметров не требуется
						; o: NZ: A - код нажатой клавиши (согласно таблицам TAI1/TAI2 WC)
						;     Z: A=#00 - неопознаная клавиша
						; 	 A=#FF - переполнение буфера клавиатуры

getKeyWithShift jp	_getKeyWithShift	; опрос клавиатуры с учётом нажатия клавиши SHIFT
						; i: входящих параметров не требуется
						; o: NZ: A - код нажатой клавиши (согласно таблицам TAI1/TAI2 WC)
						;     Z: A=#00 - неопознаная клавиша
						;  	 A=#FF - переполнение буфера клавиатуры

setRamPage	jp	_setRamPage		; включение страницы на #C000 (из выделенного блока)
						; нумерация совпадает с использующейся в +36
						; i:A - номер страницы (от 0…)
						;   #FF - страница с фонтом (1го текстового экрана)
						;   #FE - первый текстовый экран (в нём панели)

setVideoPage	jp	_setVideoPage		; включение видео-страницы на #C000
						; i:A - номер видео-страницы
						;   #00-#0F - страницы из 1го видео буфера
						;   #10-#1F - страницы из 2го видео буфера

setVideoBuffer	jp	_setVideoBuffer		; установка активного видео-буфера
						; i:A - номер видео-буфера
						;   #01 - 1й видео буфер (16 страниц)
						;   #02 - 2й видео буфер (16 страниц)

setVideoMode	jp	_setVideoMode		; включение видео режима (разрешение+тип)
						; i:A - видео режим, биты:
						;   [7-6]: %00 - 256x192
						;          %01 - 320x200
						;          %10 - 320x240
						;          %11 - 360x288
						;   [5-2]: %0000
						;   [1-0]: %00 - ZX
						;          %01 - 16c
						;          %10 - 256c
						;          %11 - txt

restoreWC	jp	_restoreWC		; Восстановление видеорежима для WC

searchEntry	jp	_searchEntry		; поиск файла/каталога в активной директории
						; i:HL - указатель на структуру: 1 байт - flag, 12 - байт имя, заканчивается #00
						;   flag: flagFile - файл
						;         flagDir - директория
						; o: Z - запись не найдена
						;    NZ - запись успешна найдена (для активации необходимо вызывать setFileBegin/setDirBegin)

setFileBegin	jp	_setFileBegin		; выставляет указатель на начало найденного файла
						; вызывается только после searchEntry
						; i: входящих параметров не требуется
						; o: на выходе так же нет флагов

setDirBegin	jp	_setDirBegin		; выставляет указатель на начало найденной директории
						; вызывается только после searchEntry
						; i: входящих параметров не требуется
						; o: на выходе так же нет флагов

load512bytes	jp	_load512bytes		; потоковая загрузка файла
						; i:HL - адрес загрузки файла (каталога)
						;   B - количество блоков по 512 байт
						; o:HL - новый адрес (?)

setHOffset	jp	_setHOffset		; выставление смещения экрана по горизонтали (X)
						; i:HL - значение в пикселях от 0 до 511

setVOffset	jp	_setVOffset		; выставление смещения экрана по вертикали (Y)
						; i:HL - значение в пикселях от 0 до 511

callDma		jp	_callDma		; работа с DMA
						; i: A - тип операции
						;    #00 - инициализация источника(S) и приёмника(D) (BHL - Source, CDE - Destination)
						;    #01 - инициализация источника(Source) (BHL)
						;    #02 - инициализация приёмника(Destination) (CDE)
						;    #03 - инициализация источника(Source) с пагой из окна (HL, B - 0-3 [номер окна])
						;    #04 - инициализация приёмника(Destination) с пагой из окна (HL, B - 0-3 [номер окна])
						;    #05 - выставление DMA_T (B - кол-во бёрстов)
						;    #06 - выставление DMA_N (B - размер бёрста)
						;
						;    #FD - запуск без ожидания завершения (o:NZ - DMA занята)
						;    #FE - запуск с ожиданием завершения (o:NZ - DMA занята)
						;    #FF - ожидание готовности DMA
						;
						; в функциях #00-#02 формат B/C следующий:
						;    [7]:%1 - выбор страницы из блока выделенного плагину (0-5)
						;        %0 - выбор страницы из видео буферов (0-31)
						;    [6-0]:номер страницы

getFatEntry	jp	_getFatEntry		; получить ENTRY(32) из коммандера (структура как в каталоге FAT32)
						; i:DE - адрес загрузки
						; o:DE(32) - указатель на структуру:
						; +#00 (11) Name. Короткое имя файла (в рамках стандарта 8.3).
						;		  Если первый байт содержит #E5 или #05 - запись свободна (соответствующий файл был удалён)
						;		  Если первый байт содержит #00 - конец записей
						; +#0B (1)  Attr. Атрибуты файла. В байте атрибутов верхние два бита являются резервными и всегда должны быть обнулены
						;		  Остальные биты распределяются таким образом, что значение:
						;		  #01 - соответствует атрибуту «только для чтения»
						;		  #02 — «скрытый»
						;		  #04 — «системный»
						;		  #20 — «архивный»
						;		  #10 — директория
						;		  #08 — метка тома (VOLUME_ID)
						;		  #0F - LFN-запись (длинное имя другого файла, не вписывающегося в рамки 8.3)
						; +#0C (1)  NTRes. Используется в Windows NT (1 в 3м бите 3 - имя следует отображать в нижнем регистре; за расширение отвечает бит 4)
						; +#0D (1)  CrtTimeTenth. Счетчик десятков миллисекунд времени создания файла, допустимы значения 0-199
						;			  Поле часто неоправданно игнорируется
						; +#0E (2)  CrtTime. Время создания файла с точностью до 2 секунд:
						;		     биты 0-4 — счетчик секунд (по две), допустимы значения 0-29, то есть 0-58 секунд
						;		     биты 5-10 — минуты, допустимы значения 0-59
						;		     биты 11-15 — часы, допустимы значения 0-23
						; +#10 (2)  CrtDate. Дата создания файла:
						;		     биты 0-4 — день месяца, допускаются значения 1-31
						;		     биты 5-8 — месяц года, допускаются значения 1-12
						;		     биты 9-15 — год, считая от 1980 года («эпоха MS-DOS»)
						;				 возможны значения от 0 до 127 включительно, то есть 1980—2107 годы
						; +#12 (2)  LstAccDate. Дата последнего доступа к файлу (то есть последнего чтения или записи — в последнем
						;			случае приравнивается WrtDate). Аналогичное поле для времени не предусмотрено
						; +#14 (2)  FstClusHI. Номер первого кластера файла (старшее слово, на томе FAT12/FAT16 равен нулю)
						; +#16 (2)  WrtTime. Время последней записи (модификации) файла, например его создания
						; +#18 (2)  WrtDate. Дата последней записи (модификации) файла, в том числе создания
						; +#1A (2)  FstClusLO. Номер первого кластера файла (младшее слово)
						; +#1C (4)  FileSize. DWORD, содержащий значение размера файла в байтах. Фундаментальное ограничение FAT32 —
						;		      максимально допустимое значение размера файла составляет 0xFFFFFFFF (то есть 4 Гб минус 1 байт)
						;
						; Если это LFN-запись, то ENTRY(32) имеет другую структуру:
						; +#00 (1)  Ord. Cлужит для нумерации записей в наборе
						; +#01 (10) Name1. Cодержит первые пять символов части имени файла, которая отражена в данной LFN-записи
						; +#0B (1)  Attr. Атрибуты равены 0х0F (ATTR_LONG_NAME)
						; +#0C (1)  Type. Обнулен и дополнительно свидетельствует, что данная запись относится к файлу с длинным именем
						; +#0D (1)  Chksum. Cодержит контрольную сумму SFN псевдонима файла, соответствующего набору LFN-записей
						; +#0E (12) Name2. Cодержит шестой-одиннадцатый символы имени файла
						; +#1A (2)  FstClusLO. В контексте LFN-записи лишено смысла и обнуляется.
						; +#1C (4)  Name3. Содержит 12-й и 13-й символы имени файла.

checkSync	jp	_checkSync		; Проверка необходимости обновления экрана
						; i: входящих параметров не требуется
						; o: NZ - новый инт был (необходимо обновить экран?)
						;    Z  - нового инта не было

printString	jp	_printString		; Печать строки в консоль (CLi)
						; i: HL - адрес строки, заканчивающейся #00

setScreen	jp	_setScreen		; Переключение межгу текстовым и графическим режимами
						; i: A - номер режима:
						;    #00 - текстовый
						;    #01 - графический

clearGfxScreen	jp	_clearGfxScreen		; Очистка графического экрана

loadResource	jp	_loadResource		; Загрузка ресурсов из файла
						; i: HL - адрес загрузки
						;    A  - тип ресурса:
						;	  resPal - ресурс палитра
						; 	  resSpr - ресурс спрайты
;---------------------------------------