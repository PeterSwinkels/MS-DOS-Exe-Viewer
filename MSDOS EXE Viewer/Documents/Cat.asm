00007430  1E                push ds                  ; Save address DS:00 on stack.
00007431  B80000            mov ax,0x0               ;
00007434  50                push ax                  ;
00007435  E8585C            call 0xd090              ; Check video state.
00007438  B81000            mov ax,0x10              ; DS = 0x10
0000743B  8ED8              mov ds,ax                ;
0000743D  E89A13            call 0x87da              ; Get machine ID.
00007440  C606900604        mov byte [0x690],0x4     ;
00007445  C706F86D0000      mov word [0x6df8],0x0
0000744B  C6069B0600        mov byte [0x69b],0x0
00007450  E8F613            call 0x8849              ; Set custom keyboard interrupt vector.
00007453  E8C213            call 0x8818              ; Set up PCJr video parameters.
00007456  A19306            mov ax,[0x693]
00007459  054002            add ax,0x240
0000745C  A3006E            mov [0x6e00],ax
0000745F  B80400            mov ax,0x4               ; Select CGA.
00007462  CD10              int 0x10                 ;
00007464  B004              mov al,0x4               ; Set [0x690] to 0x6 if machine is a PCJr. If not, [0x690] is set to 0x4.
00007466  803E9706FD        cmp byte [0x697],0xfd    ;
0000746B  7402              jz 0x746f                ;
0000746D  B006              mov al,0x6		     ;
0000746F  A29006            mov [0x690],al           ;
00007472  B40B              mov ah,0xb               ; Select palette 1.
00007474  BB0101            mov bx,0x101             ;
00007477  CD10              int 0x10                 ;
00007479  C70616040000      mov word [0x416],0x0
0000747F  C70604000000      mov word [0x4],0x0       ; Select a palette.
00007485  E8D91C            call 0x9161              ; 
00007488  803E9706FD        cmp byte [0x697],0xfd    ; Set palette 1 on PCJr.
0000748D  7406              jz 0x7495                ;
0000748F  BAD903            mov dx,0x3d9             ;
00007492  B020              mov al,0x20              ;
00007494  EE                out dx,al                ;
00007495  E8A82D            call 0xa240              ; Initialize the random number generator.
00007498  E87626            call 0x9b11		     ; Write seven null bytes to [DS:0x1f89].
0000749B  E86C26            call 0x9b0a		     ; Write seven null bytes to [DS:0x1f82].
0000749E  C6061A0400        mov byte [0x41a],0x0
000074A3  B8FFFF            mov ax,0xffff
000074A6  A31D04            mov [0x41d],ax
000074A9  A31F04            mov [0x41f],ax
000074AC  C6060000FF        mov byte [0x0],0xff
000074B1  E80C26            call 0x9ac0		     ; Perform some form of check on the previously written seven bytes.
000074B4  C70608000000      mov word [0x8],0x0
000074BA  C70604000000      mov word [0x4],0x0       ; Select a palette.
000074C0  E89E1C            call 0x9161		     ;
000074C3  E88B5A            call 0xcf51	   	     ; Turn off the PC-Speaker.
000074C6  E8175C            call 0xd0e0
000074C9  E8855A            call 0xcf51		     ; Turn off the PC-Speaker.
000074CC  803E1A0400        cmp byte [0x41a],0x0     ; Go the start of the game loop if ???
000074D1  750B              jnz 0x74de               ;
000074D3  E87B5A            call 0xcf51		     ; Turn off the PC-Speaker. This is where the game restarts upon game over.
000074D6  E83C5E            call 0xd315
000074D9  C6061A0401        mov byte [0x41a],0x1
000074DE  A1F86D            mov ax,[0x6df8]	     ; This where the level (re)starts.
000074E1  A30800            mov [0x8],ax
000074E4  C606801F03        mov byte [0x1f80],0x3    ; Set number of lives.
000074E9  E81E26            call 0x9b0a              ; Write seven null bytes to [DS:0x1f82].
000074EC  C70604000000      mov word [0x4],0x0       ; Select a palette.
000074F2  E86C1C            call 0x9161              ;
000074F5  E8595A            call 0xcf51	   	     ; Turn off the PC-Speaker.
000074F8  C706301C0000      mov word [0x1c30],0x0
000074FE  2AE4              sub ah,ah                ; Get clock tick count.
00007500  CD1A              int 0x1a                 ;
00007502  89161204          mov [0x412],dx           ;
00007506  C70614040000      mov word [0x414],0x0
0000750C  C606180400        mov byte [0x418],0x0
00007511  C606190400        mov byte [0x419],0x0
00007516  C6061C0400        mov byte [0x41c],0x0     ; Turn game over flag off.
0000751B  C6061B0400        mov byte [0x41b],0x0     ; Turn restart flag off.
00007520  E82E5A            call 0xcf51		     ; Turn off the PC-Speaker.
00007523  803E801F00        cmp byte [0x1f80],0x0    ; Check whether there are any lives remaining.
00007528  7487              jz 0x74b1
0000752A  803E1B0400        cmp byte [0x41b],0x0     ; Restart the game if the restart flag is set.
0000752F  75AD              jnz 0x74de               ;
00007531  803E1C0400        cmp byte [0x41c],0x0     ; Check for game over and jump to just before the game loop starts.
00007536  759B              jnz 0x74d3               ;
00007538  E8F528            call 0x9e30              ; Draw the title screen.
0000753B  E8F252            call 0xc830		     ; Draw more title screen related stuff.
0000753E  C606811FFF        mov byte [0x1f81],0xff
00007543  E80B5A            call 0xcf51	 	     ; Turn off the PC-Speaker.
00007546  C70604000000      mov word [0x4],0x0
0000754C  803E190400        cmp byte [0x419],0x0
00007551  7414              jz 0x7567
00007553  E87B06            call 0x7bd1
00007556  C606500502        mov byte [0x550],0x2
0000755B  C606760501        mov byte [0x576],0x1
00007560  C606780520        mov byte [0x578],0x20
00007565  EB09              jmp short 0x7570
00007567  C70679050000      mov word [0x579],0x0
0000756D  E8CD05            call 0x7b3d
00007570  E8FD1C            call 0x9270
00007573  E8EA16            call 0x8c60
00007576  E8C720            call 0x9640
00007579  E8E421            call 0x9760
0000757C  E8A325            call 0x9b22
0000757F  E8AA25            call 0x9b2c
00007582  E86857            call 0xcced
00007585  803E801F00        cmp byte [0x1f80],0x0  ; Check whether there are any lives remaining.
0000758A  7503              jnz 0x758f
0000758C  E922FF            jmp 0x74b1
0000758F  E8D611            call 0x8768;;;
00007592  803E1C0400        cmp byte [0x41c],0x0
00007597  7403              jz 0x759c
00007599  E937FF            jmp 0x74d3
0000759C  803E1B0400        cmp byte [0x41b],0x0
000075A1  7403              jz 0x75a6
000075A3  E938FF            jmp 0x74de           ; Game loop.
000075A6  E88710            call 0x8630
000075A9  E86907            call 0x7d15
000075AC  E8E41C            call 0x9293
000075AF  803EB81C00        cmp byte [0x1cb8],0x0
000075B4  750B              jnz 0x75c1
000075B6  FE060F04          inc byte [0x40f]
000075BA  F6060F0403        test byte [0x40f],0x3
000075BF  75C4              jnz 0x7585
000075C1  E8D952            call 0xc89d
000075C4  E80903            call 0x78d0
000075C7  E89C17            call 0x8d66
000075CA  E8AE16            call 0x8c7b
000075CD  E87620            call 0x9646
000075D0  E8D821            call 0x97ab
000075D3  E80D25            call 0x9ae3
000075D6  803E510500        cmp byte [0x551],0x0
000075DB  74A8              jz 0x7585
000075DD  803E801F00        cmp byte [0x1f80],0x0  ; Check whether there are any lives remaining.
000075E2  7503              jnz 0x75e7
000075E4  E9CAFE            jmp 0x74b1
000075E7  2AE4              sub ah,ah
000075E9  CD1A              int 0x1a
000075EB  89161004          mov [0x410],dx
000075EF  A17905            mov ax,[0x579]
000075F2  A30100            mov [0x1],ax
000075F5  A07B05            mov al,[0x57b]
000075F8  A20300            mov [0x3],al
000075FB  C606190401        mov byte [0x419],0x1
00007600  803E180400        cmp byte [0x418],0x0
00007605  740E              jz 0x7615
00007607  C606180400        mov byte [0x418],0x0
0000760C  C70604000700      mov word [0x4],0x7
00007612  EB54              jmp short 0x7668
00007614  90                nop
00007615  E8152C            call 0xa22d            ; Get a random number.
00007618  F6C2A0            test dl,0xa0
0000761B  741D              jz 0x763a
0000761D  8B1E0800          mov bx,[0x8]
00007621  81E30300          and bx,0x3
00007625  83FB03            cmp bx,byte +0x3
00007628  7410              jz 0x763a
0000762A  B102              mov cl,0x2
0000762C  D3E3              shl bx,cl
0000762E  81E20300          and dx,0x3
00007632  03DA              add bx,dx
00007634  8A872104          mov al,[bx+0x421]
00007638  EB12              jmp short 0x764c
0000763A  E8F02B            call 0xa22d            ; Get a random number.
0000763D  81E20700          and dx,0x7
00007641  83FA05            cmp dx,byte +0x5
00007644  73F4              jnc 0x763a
00007646  8BDA              mov bx,dx
00007648  8A872D04          mov al,[bx+0x42d]
0000764C  2AE4              sub ah,ah
0000764E  3B061D04          cmp ax,[0x41d]
00007652  7506              jnz 0x765a
00007654  3B061F04          cmp ax,[0x41f]
00007658  74BB              jz 0x7615
0000765A  A30400            mov [0x4],ax
0000765D  8B0E1D04          mov cx,[0x41d]
00007661  890E1F04          mov [0x41f],cx
00007665  A31D04            mov [0x41d],ax
00007668  C70606000000      mov word [0x6],0x0
0000766E  8B1E0400          mov bx,[0x4]
00007672  83FB07            cmp bx,byte +0x7
00007675  7602              jna 0x7679
00007677  2BDB              sub bx,bx
00007679  D1E3              shl bx,1
0000767B  2EFFA75002        jmp [cs:bx+0x250]
00007680  E203              loop 0x7685
00007682  E203              loop 0x7687
00007684  59                pop cx
00007685  0494              add al,0x94
00007687  034903            add cx,[bx+di+0x3]
0000768A  FE02              inc byte [bp+si]
0000768C  AA                stosb
0000768D  026002            add ah,[bx+si+0x2]
00007690  C70604000700      mov word [0x4],0x7
00007696  E88719            call 0x9020
00007699  E82425            call 0x9bc0
0000769C  E83205            call 0x7bd1
0000769F  E8CE1B            call 0x9270
000076A2  E89031            call 0xa835
000076A5  E8885E            call 0xd530
000076A8  E8DE4C            call 0xc389
000076AB  E83F56            call 0xcced
000076AE  E8B710            call 0x8768 ;;;
000076B1  E87C0F            call 0x8630
000076B4  E8E651            call 0xc89d
000076B7  E85B06            call 0x7d15
000076BA  E8795E            call 0xd536
000076BD  E8D62C            call 0xa396
000076C0  E8CD2B            call 0xa290
000076C3  E87A49            call 0xc040
000076C6  A05105            mov al,[0x551]
000076C9  0A065305          or al,[0x553]
000076CD  0A061C04          or al,[0x41c]
000076D1  0A061B04          or al,[0x41b]
000076D5  74D7              jz 0x76ae
000076D7  E97D01            jmp 0x7857
000076DA  C70604000600      mov word [0x4],0x6
000076E0  E83D19            call 0x9020
000076E3  E8DA24            call 0x9bc0
000076E6  E84749            call 0xc030
000076E9  E8E504            call 0x7bd1
000076EC  E84631            call 0xa835
000076EF  E87E1B            call 0x9270
000076F2  E8F855            call 0xcced
000076F5  E87010            call 0x8768;;;
000076F8  E8350F            call 0x8630
000076FB  E89F51            call 0xc89d
000076FE  E87246            call 0xbd73
00007701  E80245            call 0xbc06
00007704  E80E06            call 0x7d15
00007707  803EB81C00        cmp byte [0x1cb8],0x0
0000770C  7405              jz 0x7713
0000770E  E8821B            call 0x9293
00007711  EB03              jmp short 0x7716
00007713  E86A2E            call 0xa580
00007716  A05105            mov al,[0x551]
00007719  0A065205          or al,[0x552]
0000771D  0A065305          or al,[0x553]
00007721  0A061B04          or al,[0x41b]
00007725  0A061C04          or al,[0x41c]
00007729  74CA              jz 0x76f5
0000772B  E92901            jmp 0x7857
0000772E  C70604000500      mov word [0x4],0x5
00007734  E8E918            call 0x9020
00007737  E88624            call 0x9bc0
0000773A  E86D42            call 0xb9aa
0000773D  E89104            call 0x7bd1
00007740  E8F230            call 0xa835
00007743  E82A1B            call 0x9270
00007746  E8A455            call 0xcced
00007749  E81C10            call 0x8768;;;
0000774C  E8E10E            call 0x8630
0000774F  E84B51            call 0xc89d
00007752  E88642            call 0xb9db
00007755  E81840            call 0xb770
00007758  E8BA05            call 0x7d15
0000775B  E8222E            call 0xa580
0000775E  E8321B            call 0x9293
00007761  A05205            mov al,[0x552]
00007764  0A065305          or al,[0x553]
00007768  0A065105          or al,[0x551]
0000776C  0A061C04          or al,[0x41c]
00007770  0A061B04          or al,[0x41b]
00007774  74D3              jz 0x7749
00007776  E9DE00            jmp 0x7857
00007779  C70604000400      mov word [0x4],0x4
0000777F  E89E18            call 0x9020
00007782  E83B24            call 0x9bc0
00007785  E84904            call 0x7bd1
00007788  E8AA30            call 0xa835
0000778B  E8E21A            call 0x9270
0000778E  E82F3D            call 0xb4c0
00007791  E85955            call 0xcced
00007794  E8D10F            call 0x8768;;;
00007797  E8960E            call 0x8630
0000779A  E80051            call 0xc89d
0000779D  E87505            call 0x7d15
000077A0  E81D3B            call 0xb2c0
000077A3  E84C3D            call 0xb4f2
000077A6  E8D72D            call 0xa580
000077A9  E8E71A            call 0x9293
000077AC  A05205            mov al,[0x552]
000077AF  0A065305          or al,[0x553]
000077B3  0A065105          or al,[0x551]
000077B7  0A061C04          or al,[0x41c]
000077BB  0A061B04          or al,[0x41b]
000077BF  74D3              jz 0x7794
000077C1  E99300            jmp 0x7857
000077C4  C70604000300      mov word [0x4],0x3
000077CA  E85318            call 0x9020
000077CD  E8F023            call 0x9bc0
000077D0  E8FE03            call 0x7bd1
000077D3  E85F30            call 0xa835
000077D6  E8971A            call 0x9270
000077D9  E88437            call 0xaf60
000077DC  E8E138            call 0xb0c0
000077DF  E80B55            call 0xcced
000077E2  E8830F            call 0x8768;;;
000077E5  E8480E            call 0x8630
000077E8  E8B250            call 0xc89d
000077EB  E82705            call 0x7d15
000077EE  E8F038            call 0xb0e1
000077F1  E87E37            call 0xaf72
000077F4  E8892D            call 0xa580
000077F7  E8991A            call 0x9293
000077FA  A05205            mov al,[0x552]
000077FD  0A065305          or al,[0x553]
00007801  0A065105          or al,[0x551]
00007805  0A061C04          or al,[0x41c]
00007809  0A061B04          or al,[0x41b]
0000780D  74D3              jz 0x77e2
0000780F  EB46              jmp short 0x7857
00007811  90                nop
00007812  C70604000100      mov word [0x4],0x1
00007818  E80518            call 0x9020
0000781B  E8A223            call 0x9bc0
0000781E  E8B003            call 0x7bd1
00007821  E81130            call 0xa835
00007824  E8491A            call 0x9270
00007827  E8C354            call 0xcced
0000782A  E83B0F            call 0x8768;;;
0000782D  E8000E            call 0x8630
00007830  E86A50            call 0xc89d
00007833  E8DF04            call 0x7d15
00007836  E8472D            call 0xa580
00007839  E8571A            call 0x9293
0000783C  E84134            call 0xac80
0000783F  803E540500        cmp byte [0x554],0x0
00007844  7543              jnz 0x7889
00007846  A05205            mov al,[0x552]
00007849  0A065105          or al,[0x551]
0000784D  0A061B04          or al,[0x41b]
00007851  0A061C04          or al,[0x41c]
00007855  74D3              jz 0x782a
00007857  803E1B0400        cmp byte [0x41b],0x0
0000785C  7403              jz 0x7861
0000785E  E97DFC            jmp 0x74de			; game loop
00007861  803E1C0400        cmp byte [0x41c],0x0
00007866  7403              jz 0x786b
00007868  E968FC            jmp 0x74d3
0000786B  803E520500        cmp byte [0x552],0x0
00007870  7405              jz 0x7877
00007872  C606190400        mov byte [0x419],0x0
00007877  A10400            mov ax,[0x4]
0000787A  A30600            mov [0x6],ax
0000787D  C70604000000      mov word [0x4],0x0
00007883  E89A17            call 0x9020
00007886  E99AFC            jmp 0x7523
00007889  C70604000200      mov word [0x4],0x2
0000788F  E88E17            call 0x9020
00007892  E82B23            call 0x9bc0
00007895  E86131            call 0xa9f9
00007898  E83603            call 0x7bd1
0000789B  C606BF1C00        mov byte [0x1cbf],0x0
000078A0  C606B81C00        mov byte [0x1cb8],0x0
000078A5  E84554            call 0xcced
000078A8  E8BD0E            call 0x8768;;;
000078AB  E8820D            call 0x8630
000078AE  E8EC4F            call 0xc89d
000078B1  E86104            call 0x7d15
000078B4  E8EE31            call 0xaaa5
000078B7  E85B33            call 0xac15
000078BA  A05205            mov al,[0x552]
000078BD  0A065305          or al,[0x553]
000078C1  0A061C04          or al,[0x41c]
000078C5  0A061B04          or al,[0x41b]
000078C9  74DD              jz 0x78a8
000078CB  EB8A              jmp short 0x7857
000078CD  0000              add [bx+si],al
000078CF  00FE              add dh,bh
000078D1  0E                push cs
000078D2  3105              xor [di],ax
000078D4  7401              jz 0x78d7
000078D6  C3                ret

000078D7  FE063105          inc byte [0x531]
000078DB  E82A0F            call 0x8808              ; Get vertical retrace status.
000078DE  75F6              jnz 0x78d6               ; Return on zero.
000078E0  803E5A0500        cmp byte [0x55a],0x0
000078E5  75EF              jnz 0x78d6
000078E7  803E731600        cmp byte [0x1673],0x0
000078EC  75E8              jnz 0x78d6
000078EE  2AE4              sub ah,ah
000078F0  CD1A              int 0x1a
000078F2  3B164405          cmp dx,[0x544]
000078F6  74DE              jz 0x78d6
000078F8  89164405          mov [0x544],dx
000078FC  8B1E0800          mov bx,[0x8]
00007900  8A873205          mov al,[bx+0x532]
00007904  803E7B0560        cmp byte [0x57b],0x60
00007909  7704              ja 0x790f
0000790B  D0E8              shr al,1
0000790D  D0E8              shr al,1
0000790F  A23105            mov [0x531],al
00007912  8B1E2F05          mov bx,[0x52f]
00007916  E86F01            call 0x7a88
00007919  7421              jz 0x793c
0000791B  A02505            mov al,[0x525]
0000791E  02872905          add al,[bx+0x529]
00007922  3C04              cmp al,0x4
00007924  72B0              jc 0x78d6
00007926  E80429            call 0xa22d            ; Get a random number.
00007929  80E203            and dl,0x3
0000792C  3A162F05          cmp dl,[0x52f]
00007930  74F4              jz 0x7926
00007932  80FA03            cmp dl,0x3
00007935  74EF              jz 0x7926
00007937  8ADA              mov bl,dl
00007939  EB2A              jmp short 0x7965
0000793B  90                nop
0000793C  8A872905          mov al,[bx+0x529]
00007940  00062505          add [0x525],al
00007944  803E250504        cmp byte [0x525],0x4
00007949  7268              jc 0x79b3
0000794B  E8DF28            call 0xa22d            ; Get a random number.
0000794E  80FA40            cmp dl,0x40
00007951  7716              ja 0x7969
00007953  E8D728            call 0xa22d            ; Get a random number.
00007956  80E203            and dl,0x3
00007959  80FA03            cmp dl,0x3
0000795C  74F5              jz 0x7953
0000795E  8ADA              mov bl,dl
00007960  E82501            call 0x7a88
00007963  75EE              jnz 0x7953
00007965  891E2F05          mov [0x52f],bx
00007969  8A872605          mov al,[bx+0x526]
0000796D  A22505            mov [0x525],al
00007970  B81000            mov ax,0x10
00007973  8EC0              mov es,ax
00007975  BFD704            mov di,0x4d7
00007978  8AA72C05          mov ah,[bx+0x52c]
0000797C  8B1E0800          mov bx,[0x8]
00007980  8A9FBA2A          mov bl,[bx+0x2aba]
00007984  8AFC              mov bh,ah
00007986  E82401            call 0x7aad
00007989  833E2F0501        cmp word [0x52f],byte +0x1
0000798E  740E              jz 0x799e
00007990  D02E4005          shr byte [0x540],1
00007994  E8CC00            call 0x7a63
00007997  D02E4005          shr byte [0x540],1
0000799B  EB0F              jmp short 0x79ac
0000799D  90                nop
0000799E  A04005            mov al,[0x540]
000079A1  D0E8              shr al,1
000079A3  D0E8              shr al,1
000079A5  E8BB00            call 0x7a63
000079A8  D02E4005          shr byte [0x540],1
000079AC  E8B400            call 0x7a63
000079AF  8B1E2F05          mov bx,[0x52f]
000079B3  803ED60400        cmp byte [0x4d6],0x0
000079B8  7446              jz 0x7a00
000079BA  A17905            mov ax,[0x579]
000079BD  80FB01            cmp bl,0x1
000079C0  742D              jz 0x79ef
000079C2  FF065F05          inc word [0x55f]
000079C6  050400            add ax,0x4
000079C9  3D2301            cmp ax,0x123
000079CC  722F              jc 0x79fd
000079CE  C6065B0511        mov byte [0x55b],0x11
000079D3  C606710501        mov byte [0x571],0x1
000079D8  C606760501        mov byte [0x576],0x1
000079DD  C606780518        mov byte [0x578],0x18
000079E2  C606720501        mov byte [0x572],0x1
000079E7  C6065C0500        mov byte [0x55c],0x0
000079EC  EB12              jmp short 0x7a00
000079EE  90                nop
000079EF  FF0E5F05          dec word [0x55f]
000079F3  2D0400            sub ax,0x4
000079F6  72D6              jc 0x79ce
000079F8  3D0800            cmp ax,0x8
000079FB  72D1              jc 0x79ce
000079FD  A37905            mov [0x579],ax
00007A00  1E                push ds
00007A01  D1E3              shl bx,1
00007A03  8B871D05          mov ax,[bx+0x51d]
00007A07  A32305            mov [0x523],ax
00007A0A  8BB71705          mov si,[bx+0x517]
00007A0E  B800B8            mov ax,0xb800      ; Video memory.
00007A11  8ED8              mov ds,ax          ;
00007A13  8EC0              mov es,ax          ;
00007A15  8BFE              mov di,si
00007A17  83FB02            cmp bx,byte +0x2
00007A1A  7505              jnz 0x7a21
00007A1C  FC                cld
00007A1D  4F                dec di
00007A1E  EB03              jmp short 0x7a23
00007A20  90                nop
00007A21  FD                std
00007A22  47                inc di
00007A23  B97F02            mov cx,0x27f
00007A26  57                push di
00007A27  56                push si
00007A28  F3A4              rep movsb
00007A2A  5E                pop si
00007A2B  5F                pop di
00007A2C  81C60020          add si,0x2000
00007A30  81C70020          add di,0x2000
00007A34  B98002            mov cx,0x280
00007A37  F3A4              rep movsb
00007A39  1F                pop ds
00007A3A  8B3E2305          mov di,[0x523]
00007A3E  8A1E2505          mov bl,[0x525]
00007A42  2AFF              sub bh,bh
00007A44  81C3D704          add bx,0x4d7
00007A48  B91000            mov cx,0x10
00007A4B  8A07              mov al,[bx]
00007A4D  268805            mov [es:di],al
00007A50  83C304            add bx,byte +0x4
00007A53  81F70020          xor di,0x2000
00007A57  F7C70020          test di,0x2000
00007A5B  7503              jnz 0x7a60
00007A5D  83C750            add di,byte +0x50
00007A60  E2E9              loop 0x7a4b
00007A62  C3                ret

00007A63  9F                lahf
00007A64  8B1E2F05          mov bx,[0x52f]
00007A68  8A9F4105          mov bl,[bx+0x541]
00007A6C  B90500            mov cx,0x5
00007A6F  80FB09            cmp bl,0x9
00007A72  740A              jz 0x7a7e
00007A74  9E                sahf
00007A75  D09F1610          rcr byte [bx+0x1016],1
00007A79  9F                lahf
00007A7A  43                inc bx
00007A7B  E2F7              loop 0x7a74
00007A7D  C3                ret

00007A7E  9E                sahf
00007A7F  D0971610          rcl byte [bx+0x1016],1
00007A83  9F                lahf
00007A84  4B                dec bx
00007A85  E2F7              loop 0x7a7e
00007A87  C3                ret

00007A88  C606D60400        mov byte [0x4d6],0x0
00007A8D  A07C05            mov al,[0x57c]
00007A90  3A873D05          cmp al,[bx+0x53d]
00007A94  7213              jc 0x7aa9
00007A96  3A873A05          cmp al,[bx+0x53a]
00007A9A  730D              jnc 0x7aa9
00007A9C  803E5C0501        cmp byte [0x55c],0x1
00007AA1  7301              jnc 0x7aa4
00007AA3  C3                ret

00007AA4  C606D60401        mov byte [0x4d6],0x1
00007AA9  3AC0              cmp al,al
00007AAB  C3                ret

00007AAC  C3                ret

00007AAD  C606400500        mov byte [0x540],0x0
00007AB2  FC                cld
00007AB3  B92000            mov cx,0x20
00007AB6  B8AAAA            mov ax,0xaaaa
00007AB9  F3AB              rep stosw
00007ABB  83EF40            sub di,byte +0x40
00007ABE  B84444            mov ax,0x4444
00007AC1  26894504          mov [es:di+0x4],ax
00007AC5  26894506          mov [es:di+0x6],ax
00007AC9  E86127            call 0xa22d            ; Get a random number.
00007ACC  3AD3              cmp dl,bl
00007ACE  7204              jc 0x7ad4
00007AD0  3AF7              cmp dh,bh
00007AD2  7701              ja 0x7ad5
00007AD4  C3                ret

00007AD5  E85527            call 0xa22d            ; Get a random number.
00007AD8  80FA18            cmp dl,0x18
00007ADB  721A              jc 0x7af7
00007ADD  80FA60            cmp dl,0x60
00007AE0  721E              jc 0x7b00
00007AE2  57                push di
00007AE3  E82800            call 0x7b0e
00007AE6  D0E0              shl al,1
00007AE8  A24005            mov [0x540],al
00007AEB  5F                pop di
00007AEC  83C702            add di,byte +0x2
00007AEF  E81C00            call 0x7b0e
00007AF2  08064005          or [0x540],al
00007AF6  C3                ret

00007AF7  B92000            mov cx,0x20
00007AFA  BE9004            mov si,0x490
00007AFD  EB07              jmp short 0x7b06
00007AFF  90                nop
00007B00  B91000            mov cx,0x10
00007B03  BE6004            mov si,0x460
00007B06  F3A5              rep movsw
00007B08  C606400503        mov byte [0x540],0x3
00007B0D  C3                ret

00007B0E  E81C27            call 0xa22d            ; Get a random number.
00007B11  81E20600          and dx,0x6
00007B15  80FA06            cmp dl,0x6
00007B18  7503              jnz 0x7b1d
00007B1A  2AC0              sub al,al
00007B1C  C3                ret

00007B1D  8BDA              mov bx,dx
00007B1F  8BB7D004          mov si,[bx+0x4d0]
00007B23  B90800            mov cx,0x8
00007B26  AD                lodsw
00007B27  AB                stosw
00007B28  83C702            add di,byte +0x2
00007B2B  E2F9              loop 0x7b26
00007B2D  B001              mov al,0x1
00007B2F  C3                ret

00007B30  C7067D050000      mov word [0x57d],0x0
00007B36  C70684060000      mov word [0x684],0x0
00007B3C  C3                ret

00007B3D  B90000            mov cx,0x0
00007B40  B401              mov ah,0x1
00007B42  813E7905A000      cmp word [0x579],0xa0
00007B48  7205              jc 0x7b4f
00007B4A  B92801            mov cx,0x128
00007B4D  B4FF              mov ah,0xff
00007B4F  88266E05          mov [0x56e],ah
00007B53  C606580503        mov byte [0x558],0x3
00007B58  C60659050C        mov byte [0x559],0xc
00007B5D  B2B4              mov dl,0xb4
00007B5F  890E7905          mov [0x579],cx
00007B63  88167B05          mov [0x57b],dl
00007B67  C6067C05E6        mov byte [0x57c],0xe6
00007B6C  E87125            call 0xa0e0
00007B6F  A35F05            mov [0x55f],ax
00007B72  C7066105030B      mov word [0x561],0xb03 ; Set the sprite size.
00007B78  E8D909            call 0x8554
00007B7B  C606710500        mov byte [0x571],0x0
00007B80  C70672050200      mov word [0x572],0x2
00007B86  C606760501        mov byte [0x576],0x1
00007B8B  C6065B0500        mov byte [0x55b],0x0
00007B90  C606500500        mov byte [0x550],0x0
00007B95  C6065C0500        mov byte [0x55c],0x0
00007B9A  C6065A0500        mov byte [0x55a],0x0
00007B9F  C606830500        mov byte [0x583],0x0
00007BA4  C606980600        mov byte [0x698],0x0
00007BA9  C606990600        mov byte [0x699],0x0
00007BAE  C606510500        mov byte [0x551],0x0
00007BB3  C606840500        mov byte [0x584],0x0
00007BB8  C606520500        mov byte [0x552],0x0
00007BBD  C70654050000      mov word [0x554],0x0
00007BC3  C606530500        mov byte [0x553],0x0
00007BC8  C6067C1200        mov byte [0x127c],0x0
00007BCD  E860FF            call 0x7b30
00007BD0  C3                ret

00007BD1  8B1E0400          mov bx,[0x4]
00007BD5  83FB00            cmp bx,byte +0x0
00007BD8  750B              jnz 0x7be5
00007BDA  8B0E0100          mov cx,[0x1]
00007BDE  8A160300          mov dl,[0x3]
00007BE2  EB0B              jmp short 0x7bef
00007BE4  90                nop
00007BE5  8A97E905          mov dl,[bx+0x5e9]
00007BE9  D0E3              shl bl,1
00007BEB  8B8FD905          mov cx,[bx+0x5d9]
00007BEF  890E7905          mov [0x579],cx
00007BF3  88167B05          mov [0x57b],dl
00007BF7  8AC2              mov al,dl
00007BF9  0432              add al,0x32
00007BFB  A27C05            mov [0x57c],al
00007BFE  E8DF24            call 0xa0e0
00007C01  A35F05            mov [0x55f],ax
00007C04  A1B20F            mov ax,[0xfb2]
00007C07  A36905            mov [0x569],ax
00007C0A  A1BE0F            mov ax,[0xfbe]
00007C0D  A36705            mov [0x567],ax
00007C10  A36105            mov [0x561],ax ; Set the sprite size.
00007C13  E83E09            call 0x8554
00007C16  C606710501        mov byte [0x571],0x1
00007C1B  C6066E0500        mov byte [0x56e],0x0
00007C20  C606760501        mov byte [0x576],0x1
00007C25  C606780540        mov byte [0x578],0x40
00007C2A  B00A              mov al,0xa
00007C2C  833E040007        cmp word [0x4],byte +0x7
00007C31  7502              jnz 0x7c35
00007C33  2AC0              sub al,al
00007C35  A25B05            mov [0x55b],al
00007C38  C606500500        mov byte [0x550],0x0
00007C3D  C6065C0500        mov byte [0x55c],0x0
00007C42  C6065A0500        mov byte [0x55a],0x0
00007C47  C606830500        mov byte [0x583],0x0
00007C4C  C606980600        mov byte [0x698],0x0
00007C51  C606990600        mov byte [0x699],0x0
00007C56  C606510500        mov byte [0x551],0x0
00007C5B  C606840500        mov byte [0x584],0x0
00007C60  C606520500        mov byte [0x552],0x0
00007C65  C70654050000      mov word [0x554],0x0
00007C6B  C606530500        mov byte [0x553],0x0
00007C70  C6067C1200        mov byte [0x127c],0x0
00007C75  E8B8FE            call 0x7b30
00007C78  833E040002        cmp word [0x4],byte +0x2
00007C7D  7522              jnz 0x7ca1
00007C7F  C606760510        mov byte [0x576],0x10
00007C84  C70674051000      mov word [0x574],0x10
00007C8A  2AE4              sub ah,ah
00007C8C  CD1A              int 0x1a
00007C8E  8916F105          mov [0x5f1],dx
00007C92  C606F30500        mov byte [0x5f3],0x0
00007C97  C606F40505        mov byte [0x5f4],0x5
00007C9C  C606F50501        mov byte [0x5f5],0x1
00007CA1  C3                ret

00007CA2  C7062A590004      mov word [0x592a],0x400
00007CA8  803E840500        cmp byte [0x584],0x0
00007CAD  7401              jz 0x7cb0
00007CAF  C3                ret
00007CB0  C606760508        mov byte [0x576],0x8
00007CB5  B2FF              mov dl,0xff
00007CB7  A07B05            mov al,[0x57b]
00007CBA  3A065226          cmp al,[0x2652]
00007CBE  7302              jnc 0x7cc2
00007CC0  B201              mov dl,0x1
00007CC2  88167105          mov [0x571],dl
00007CC6  A17905            mov ax,[0x579]
00007CC9  2B065026          sub ax,[0x2650]
00007CCD  B2FF              mov dl,0xff
00007CCF  7704              ja 0x7cd5
00007CD1  B201              mov dl,0x1
00007CD3  F7D0              not ax
00007CD5  88166E05          mov [0x56e],dl
00007CD9  80FC00            cmp ah,0x0
00007CDC  7403              jz 0x7ce1
00007CDE  B8FF00            mov ax,0xff
00007CE1  F6D0              not al
00007CE3  3C30              cmp al,0x30
00007CE5  7302              jnc 0x7ce9
00007CE7  B030              mov al,0x30
00007CE9  8AD8              mov bl,al
00007CEB  D0EB              shr bl,1
00007CED  D0EB              shr bl,1
00007CEF  2AC3              sub al,bl
00007CF1  A27805            mov [0x578],al
00007CF4  B105              mov cl,0x5
00007CF6  D2E8              shr al,cl
00007CF8  A37205            mov [0x572],ax
00007CFB  C6065C0500        mov byte [0x55c],0x0
00007D00  C606E03900        mov byte [0x39e0],0x0
00007D05  C606770501        mov byte [0x577],0x1
00007D0A  C6065B0510        mov byte [0x55b],0x10
00007D0F  C606840501        mov byte [0x584],0x1
00007D14  C3                ret

00007D15  2AE4              sub ah,ah
00007D17  CD1A              int 0x1a
00007D19  3B167D05          cmp dx,[0x57d]
00007D1D  750E              jnz 0x7d2d
00007D1F  833E840600        cmp word [0x684],byte +0x0
00007D24  7406              jz 0x7d2c
00007D26  FF0E8406          dec word [0x684]
00007D2A  7410              jz 0x7d3c
00007D2C  C3                ret
00007D2D  B82000            mov ax,0x20
00007D30  803E9706FD        cmp byte [0x697],0xfd      ; Check for PCJr.
00007D35  7502              jnz 0x7d39
00007D37  D1E8              shr ax,1
00007D39  A38406            mov [0x684],ax
00007D3C  833E040002        cmp word [0x4],byte +0x2
00007D41  740A              jz 0x7d4d
00007D43  8A0E7105          mov cl,[0x571]
00007D47  0A0E6E05          or cl,[0x56e]
00007D4B  7509              jnz 0x7d56
00007D4D  52                push dx
00007D4E  50                push ax
00007D4F  E8B60A            call 0x8808   ; Get vertical retrace status.
00007D52  58                pop ax
00007D53  5A                pop dx
00007D54  74D6              jz 0x7d2c
00007D56  89167D05          mov [0x57d],dx
00007D5A  A37F05            mov [0x57f],ax
00007D5D  833E040004        cmp word [0x4],byte +0x4
00007D62  7507              jnz 0x7d6b
00007D64  803EE13900        cmp byte [0x39e1],0x0
00007D69  75C1              jnz 0x7d2c
00007D6B  833E040006        cmp word [0x4],byte +0x6
00007D70  7507              jnz 0x7d79
00007D72  803EBD4400        cmp byte [0x44bd],0x0
00007D77  75B3              jnz 0x7d2c
00007D79  833E040002        cmp word [0x4],byte +0x2
00007D7E  7403              jz 0x7d83
00007D80  E95902            jmp 0x7fdc
00007D83  8B360800          mov si,[0x8]
00007D87  D1E6              shl si,1
00007D89  A17D05            mov ax,[0x57d]
00007D8C  2B06F105          sub ax,[0x5f1]
00007D90  3B848905          cmp ax,[si+0x589]
00007D94  7270              jc 0x7e06
00007D96  3B849905          cmp ax,[si+0x599]
00007D9A  7205              jc 0x7da1
00007D9C  C606520501        mov byte [0x552],0x1
00007DA1  FE0EF505          dec byte [0x5f5]
00007DA5  7542              jnz 0x7de9
00007DA7  E80550            call 0xcdaf
00007DAA  C606F50506        mov byte [0x5f5],0x6
00007DAF  A0F405            mov al,[0x5f4]
00007DB2  803E7B05B3        cmp byte [0x57b],0xb3
00007DB7  7209              jc 0x7dc2
00007DB9  3CC8              cmp al,0xc8
00007DBB  7305              jnc 0x7dc2
00007DBD  041E              add al,0x1e
00007DBF  A2F405            mov [0x5f4],al
00007DC2  8A167B05          mov dl,[0x57b]
00007DC6  2AD0              sub dl,al
00007DC8  7302              jnc 0x7dcc
00007DCA  2AD2              sub dl,dl
00007DCC  8B0E7905          mov cx,[0x579]
00007DD0  80E2F8            and dl,0xf8
00007DD3  E80A23            call 0xa0e0
00007DD6  8BF8              mov di,ax
00007DD8  BE4E06            mov si,0x64e
00007DDB  B800B8            mov ax,0xb800   ; Video memory.
00007DDE  8EC0              mov es,ax       ;
00007DE0  BD0E00            mov bp,0xe
00007DE3  B90305            mov cx,0x503
00007DE6  E87C23            call 0xa165
00007DE9  C6066E0500        mov byte [0x56e],0x0
00007DEE  C606710501        mov byte [0x571],0x1
00007DF3  C606F30501        mov byte [0x5f3],0x1
00007DF8  C606760520        mov byte [0x576],0x20
00007DFD  2BDB              sub bx,bx     ; Black background.
00007DFF  B40B              mov ah,0xb    ;
00007E01  CD10              int 0x10      ;
00007E03  E9B000            jmp 0x7eb6
00007E06  8B360800          mov si,[0x8]
00007E0A  D1E6              shl si,1
00007E0C  2BDB              sub bx,bx
00007E0E  3B84A905          cmp ax,[si+0x5a9]
00007E12  7212              jc 0x7e26
00007E14  FEC3              inc bl
00007E16  3B84B905          cmp ax,[si+0x5b9]
00007E1A  720A              jc 0x7e26
00007E1C  B305              mov bl,0x5
00007E1E  3B84C905          cmp ax,[si+0x5c9]
00007E22  7202              jc 0x7e26
00007E24  FECB              dec bl
00007E26  B40B              mov ah,0xb     ; Background/palette.
00007E28  CD10              int 0x10       ;
00007E2A  A06E05            mov al,[0x56e]
00007E2D  A26F05            mov [0x56f],al
00007E30  A07105            mov al,[0x571]
00007E33  A27005            mov [0x570],al
00007E36  A09806            mov al,[0x698]
00007E39  3C00              cmp al,0x0
00007E3B  750D              jnz 0x7e4a
00007E3D  833E740510        cmp word [0x574],byte +0x10
00007E42  721A              jc 0x7e5e
00007E44  FF0E7405          dec word [0x574]
00007E48  EB1D              jmp short 0x7e67
00007E4A  3A066E05          cmp al,[0x56e]
00007E4E  750E              jnz 0x7e5e
00007E50  833E740530        cmp word [0x574],byte +0x30
00007E55  7310              jnc 0x7e67
00007E57  8306740503        add word [0x574],byte +0x3
00007E5C  EB09              jmp short 0x7e67
00007E5E  A26E05            mov [0x56e],al
00007E61  C70674052000      mov word [0x574],0x20
00007E67  A17405            mov ax,[0x574]
00007E6A  B103              mov cl,0x3
00007E6C  D3E8              shr ax,cl
00007E6E  8B1E0800          mov bx,[0x8]
00007E72  D0E3              shl bl,1
00007E74  3B876C06          cmp ax,[bx+0x66c]
00007E78  7604              jna 0x7e7e
00007E7A  8B876C06          mov ax,[bx+0x66c]
00007E7E  A37205            mov [0x572],ax
00007E81  E87505            call 0x83f9
00007E84  A09906            mov al,[0x699]
00007E87  3C00              cmp al,0x0
00007E89  750F              jnz 0x7e9a
00007E8B  F6D0              not al
00007E8D  803E760510        cmp byte [0x576],0x10
00007E92  721A              jc 0x7eae
00007E94  FE0E7605          dec byte [0x576]
00007E98  EB1C              jmp short 0x7eb6
00007E9A  3A067105          cmp al,[0x571]
00007E9E  750E              jnz 0x7eae
00007EA0  803E760540        cmp byte [0x576],0x40
00007EA5  730F              jnc 0x7eb6
00007EA7  8006760504        add byte [0x576],0x4
00007EAC  EB08              jmp short 0x7eb6
00007EAE  A27105            mov [0x571],al
00007EB1  C606760520        mov byte [0x576],0x20
00007EB6  8B360800          mov si,[0x8]
00007EBA  8A167B05          mov dl,[0x57b]
00007EBE  B104              mov cl,0x4
00007EC0  8A1E7605          mov bl,[0x576]
00007EC4  D2EB              shr bl,cl
00007EC6  3A9C7C06          cmp bl,[si+0x67c]
00007ECA  7604              jna 0x7ed0
00007ECC  8A9C7C06          mov bl,[si+0x67c]
00007ED0  A07105            mov al,[0x571]
00007ED3  3C01              cmp al,0x1
00007ED5  7227              jc 0x7efe
00007ED7  750B              jnz 0x7ee4
00007ED9  02D3              add dl,bl
00007EDB  80FAB4            cmp dl,0xb4
00007EDE  721E              jc 0x7efe
00007EE0  B2B3              mov dl,0xb3
00007EE2  EB1A              jmp short 0x7efe
00007EE4  2AD3              sub dl,bl
00007EE6  7205              jc 0x7eed
00007EE8  80FA03            cmp dl,0x3
00007EEB  7711              ja 0x7efe
00007EED  A1B809            mov ax,[0x9b8]
00007EF0  3B065D05          cmp ax,[0x55d]
00007EF4  7506              jnz 0x7efc
00007EF6  A17D05            mov ax,[0x57d]
00007EF9  A3F105            mov [0x5f1],ax
00007EFC  B202              mov dl,0x2
00007EFE  88167B05          mov [0x57b],dl
00007F02  8B0E7905          mov cx,[0x579]
00007F06  E8D721            call 0xa0e0
00007F09  A36305            mov [0x563],ax
00007F0C  803EF30500        cmp byte [0x5f3],0x0
00007F11  7406              jz 0x7f19
00007F13  BB1000            mov bx,0x10
00007F16  EB7C              jmp short 0x7f94
00007F18  90                nop
00007F19  A06E05            mov al,[0x56e]
00007F1C  3A066F05          cmp al,[0x56f]
00007F20  7509              jnz 0x7f2b
00007F22  A07105            mov al,[0x571]
00007F25  3A067005          cmp al,[0x570]
00007F29  7405              jz 0x7f30
00007F2B  BB1800            mov bx,0x18
00007F2E  EB64              jmp short 0x7f94
00007F30  FF068705          inc word [0x587]
00007F34  8B1E8705          mov bx,[0x587]
00007F38  A09806            mov al,[0x698]
00007F3B  0A069906          or al,[0x699]
00007F3F  7502              jnz 0x7f43
00007F41  D0EB              shr bl,1
00007F43  803E7B05B3        cmp byte [0x57b],0xb3
00007F48  7207              jc 0x7f51
00007F4A  803E710501        cmp byte [0x571],0x1
00007F4F  741B              jz 0x7f6c
00007F51  803E7B0504        cmp byte [0x57b],0x4
00007F56  7707              ja 0x7f5f
00007F58  803E990600        cmp byte [0x699],0x0
00007F5D  7524              jnz 0x7f83
00007F5F  A07605            mov al,[0x576]
00007F62  2AE4              sub ah,ah
00007F64  D1E8              shr ax,1
00007F66  3B067405          cmp ax,[0x574]
00007F6A  7317              jnc 0x7f83
00007F6C  803E6E0500        cmp byte [0x56e],0x0
00007F71  7410              jz 0x7f83
00007F73  81E30600          and bx,0x6
00007F77  803E6E0501        cmp byte [0x56e],0x1
00007F7C  7416              jz 0x7f94
00007F7E  80CB08            or bl,0x8
00007F81  EB11              jmp short 0x7f94
00007F83  81E30200          and bx,0x2
00007F87  80CB10            or bl,0x10
00007F8A  803E710501        cmp byte [0x571],0x1
00007F8F  7503              jnz 0x7f94
00007F91  80C304            add bl,0x4
00007F94  8B87A609          mov ax,[bx+0x9a6]
00007F98  A35D05            mov [0x55d],ax
00007F9B  8B87C009          mov ax,[bx+0x9c0]
00007F9F  A36505            mov [0x565],ax
00007FA2  B030              mov al,0x30
00007FA4  B9BC02            mov cx,0x2bc
00007FA7  803E9706FD        cmp byte [0x697],0xfd        ; Check for PCJr.
00007FAC  7219              jc 0x7fc7
00007FAE  7405              jz 0x7fb5
00007FB0  B008              mov al,0x8
00007FB2  B9E803            mov cx,0x3e8
00007FB5  38067B05          cmp [0x57b],al
00007FB9  770C              ja 0x7fc7
00007FBB  E84A08            call 0x8808   ; Get vertical retrace status.
00007FBE  75FB              jnz 0x7fbb
00007FC0  E84508            call 0x8808   ; Get vertical retrace status.
00007FC3  74FB              jz 0x7fc0
00007FC5  E2FE              loop 0x7fc5
00007FC7  E84906            call 0x8613
00007FCA  A16305            mov ax,[0x563]
00007FCD  A35F05            mov [0x55f],ax
00007FD0  E8A205            call 0x8575
00007FD3  E8FA28            call 0xa8d0
00007FD6  7303              jnc 0x7fdb
00007FD8  E89A05            call 0x8575
00007FDB  C3                ret
00007FDC  E8CB0F            call 0x8faa
00007FDF  7301              jnc 0x7fe2
00007FE1  C3                ret
00007FE2  803EB81C00        cmp byte [0x1cb8],0x0
00007FE7  75F8              jnz 0x7fe1
00007FE9  803E580500        cmp byte [0x558],0x0
00007FEE  745C              jz 0x804c
00007FF0  803E590500        cmp byte [0x559],0x0
00007FF5  740C              jz 0x8003
00007FF7  803EBF1C00        cmp byte [0x1cbf],0x0
00007FFC  7504              jnz 0x8002
00007FFE  FE0E5905          dec byte [0x559]
00008002  C3                ret
00008003  FE0E5805          dec byte [0x558]
00008007  750C              jnz 0x8015
00008009  C70672050800      mov word [0x572],0x8
0000800F  E8E703            call 0x83f9
00008012  EB38              jmp short 0x804c
00008014  90                nop
00008015  E83804            call 0x8450
00008018  891E5D05          mov [0x55d],bx
0000801C  A05805            mov al,[0x558]
0000801F  8A266E05          mov ah,[0x56e]
00008023  E89103            call 0x83b7
00008026  803E580502        cmp byte [0x558],0x2
0000802B  7403              jz 0x8030
0000802D  E8E305            call 0x8613
00008030  E8770F            call 0x8faa
00008033  7216              jc 0x804b
00008035  E8ED14            call 0x9525
00008038  7211              jc 0x804b
0000803A  8A167B05          mov dl,[0x57b]
0000803E  8B0E7905          mov cx,[0x579]
00008042  E89B20            call 0xa0e0
00008045  A35F05            mov [0x55f],ax
00008048  E82A05            call 0x8575
0000804B  C3                ret
0000804C  803E5C0501        cmp byte [0x55c],0x1
00008051  7247              jc 0x809a
00008053  753A              jnz 0x808f
00008055  FE065C05          inc byte [0x55c]
00008059  C70672050600      mov word [0x572],0x6
0000805F  8A167B05          mov dl,[0x57b]
00008063  8B0E7905          mov cx,[0x579]
00008067  E87620            call 0xa0e0
0000806A  A36305            mov [0x563],ax
0000806D  E8A305            call 0x8613
00008070  E8370F            call 0x8faa
00008073  7221              jc 0x8096
00008075  E8AD14            call 0x9525
00008078  721C              jc 0x8096
0000807A  A16305            mov ax,[0x563]
0000807D  A35F05            mov [0x55f],ax
00008080  C7066505030E      mov word [0x565],0xe03
00008086  C7065D05DA09      mov word [0x55d],0x9da
0000808C  E8E604            call 0x8575
0000808F  803E990600        cmp byte [0x699],0x0
00008094  7501              jnz 0x8097
00008096  C3                ret
00008097  E90E02            jmp 0x82a8
0000809A  803E710500        cmp byte [0x571],0x0
0000809F  7503              jnz 0x80a4
000080A1  E9AF01            jmp 0x8253
000080A4  E85203            call 0x83f9
000080A7  7317              jnc 0x80c0
000080A9  C6066E0500        mov byte [0x56e],0x0
000080AE  C606760502        mov byte [0x576],0x2
000080B3  C606710501        mov byte [0x571],0x1
000080B8  C6065B0500        mov byte [0x55b],0x0
000080BD  EB32              jmp short 0x80f1
000080BF  90                nop
000080C0  A07805            mov al,[0x578]
000080C3  28067705          sub [0x577],al
000080C7  7328              jnc 0x80f1
000080C9  803E710501        cmp byte [0x571],0x1
000080CE  7416              jz 0x80e6
000080D0  803E760501        cmp byte [0x576],0x1
000080D5  7607              jna 0x80de
000080D7  FE0E7605          dec byte [0x576]
000080DB  EB14              jmp short 0x80f1
000080DD  90                nop
000080DE  C606710501        mov byte [0x571],0x1
000080E3  EB0C              jmp short 0x80f1
000080E5  90                nop
000080E6  803E760504        cmp byte [0x576],0x4
000080EB  7304              jnc 0x80f1
000080ED  FE067605          inc byte [0x576]
000080F1  803E5A0500        cmp byte [0x55a],0x0
000080F6  751F              jnz 0x8117
000080F8  803E5B0500        cmp byte [0x55b],0x0
000080FD  7406              jz 0x8105
000080FF  FE0E5B05          dec byte [0x55b]
00008103  7512              jnz 0x8117
00008105  803E710501        cmp byte [0x571],0x1
0000810A  750B              jnz 0x8117
0000810C  E82909            call 0x8a38
0000810F  7306              jnc 0x8117
00008111  A07C05            mov al,[0x57c]
00008114  EB43              jmp short 0x8159
00008116  90                nop
00008117  A07C05            mov al,[0x57c]
0000811A  803E710501        cmp byte [0x571],0x1
0000811F  7415              jz 0x8136
00008121  2A067605          sub al,[0x576]
00008125  7358              jnc 0x817f
00008127  2AC0              sub al,al
00008129  C606710501        mov byte [0x571],0x1
0000812E  C606760501        mov byte [0x576],0x1
00008133  EB4A              jmp short 0x817f
00008135  90                nop
00008136  02067605          add al,[0x576]
0000813A  3CE6              cmp al,0xe6
0000813C  7641              jna 0x817f
0000813E  833E040007        cmp word [0x4],byte +0x7
00008143  750D              jnz 0x8152
00008145  3CF8              cmp al,0xf8
00008147  7236              jc 0x817f
00008149  B0F8              mov al,0xf8
0000814B  C606510501        mov byte [0x551],0x1
00008150  EB2D              jmp short 0x817f
00008152  B0E6              mov al,0xe6
00008154  C606500500        mov byte [0x550],0x0
00008159  C606710500        mov byte [0x571],0x0
0000815E  C606840500        mov byte [0x584],0x0
00008163  C70672050200      mov word [0x572],0x2
00008169  C6065B0500        mov byte [0x55b],0x0
0000816E  C6065A0500        mov byte [0x55a],0x0
00008173  803E5C0500        cmp byte [0x55c],0x0
00008178  7405              jz 0x817f
0000817A  50                push ax
0000817B  E8744D            call 0xcef2
0000817E  58                pop ax
0000817F  A27C05            mov [0x57c],al
00008182  2C32              sub al,0x32
00008184  7302              jnc 0x8188
00008186  2AC0              sub al,al
00008188  A27B05            mov [0x57b],al
0000818B  8A167B05          mov dl,[0x57b]
0000818F  8B0E7905          mov cx,[0x579]
00008193  E84A1F            call 0xa0e0
00008196  A36305            mov [0x563],ax
00008199  803E830500        cmp byte [0x583],0x0
0000819E  7503              jnz 0x81a3
000081A0  E87004            call 0x8613
000081A3  E8040E            call 0x8faa
000081A6  724C              jc 0x81f4
000081A8  E87A13            call 0x9525
000081AB  7247              jc 0x81f4
000081AD  A16305            mov ax,[0x563]
000081B0  A35F05            mov [0x55f],ax
000081B3  803E840500        cmp byte [0x584],0x0
000081B8  7417              jz 0x81d1
000081BA  8306850502        add word [0x585],byte +0x2
000081BF  8B1E8505          mov bx,[0x585]
000081C3  81E30E00          and bx,0xe
000081C7  8B87C20F          mov ax,[bx+0xfc2]
000081CB  8B9FD20F          mov bx,[bx+0xfd2]
000081CF  EB07              jmp short 0x81d8
000081D1  A16905            mov ax,[0x569]
000081D4  8B1E6705          mov bx,[0x567]
000081D8  A35D05            mov [0x55d],ax
000081DB  891E6505          mov [0x565],bx
000081DF  B032              mov al,0x32
000081E1  2A067C05          sub al,[0x57c]
000081E5  7427              jz 0x820e
000081E7  7225              jc 0x820e
000081E9  B96801            mov cx,0x168
000081EC  E2FE              loop 0x81ec
000081EE  2AF8              sub bh,al
000081F0  7402              jz 0x81f4
000081F2  7306              jnc 0x81fa
000081F4  C606830501        mov byte [0x583],0x1
000081F9  C3                ret
000081FA  891E6505          mov [0x565],bx
000081FE  8AE3              mov ah,bl
00008200  D0E4              shl ah,1
00008202  F6E4              mul ah
00008204  03066905          add ax,[0x569]
00008208  A35D05            mov [0x55d],ax
0000820B  EB42              jmp short 0x824f
0000820D  90                nop
0000820E  833E040007        cmp word [0x4],byte +0x7
00008213  7509              jnz 0x821e
00008215  A07B05            mov al,[0x57b]
00008218  2CBB              sub al,0xbb
0000821A  7233              jc 0x824f
0000821C  730E              jnc 0x822c
0000821E  803E500502        cmp byte [0x550],0x2
00008223  752A              jnz 0x824f
00008225  A07B05            mov al,[0x57b]
00008228  2C5E              sub al,0x5e
0000822A  7223              jc 0x824f
0000822C  2AF8              sub bh,al
0000822E  7402              jz 0x8232
00008230  7314              jnc 0x8246
00008232  833E040007        cmp word [0x4],byte +0x7
00008237  7506              jnz 0x823f
00008239  C606510501        mov byte [0x551],0x1
0000823E  C3                ret
0000823F  E8FBF8            call 0x7b3d
00008242  E8B64B            call 0xcdfb
00008245  C3                ret
00008246  891E6505          mov [0x565],bx
0000824A  C606760502        mov byte [0x576],0x2
0000824F  E82303            call 0x8575
00008252  C3                ret
00008253  833E040007        cmp word [0x4],byte +0x7
00008258  7407              jz 0x8261
0000825A  803E7B05B4        cmp byte [0x57b],0xb4
0000825F  7347              jnc 0x82a8
00008261  E8D407            call 0x8a38
00008264  720D              jc 0x8273
00008266  C6066E0500        mov byte [0x56e],0x0
0000826B  C606710501        mov byte [0x571],0x1
00008270  EB6F              jmp short 0x82e1
00008272  90                nop
00008273  833E040000        cmp word [0x4],byte +0x0
00008278  752E              jnz 0x82a8
0000827A  E8AA14            call 0x9727
0000827D  7207              jc 0x8286
0000827F  C6066C0500        mov byte [0x56c],0x0
00008284  EB22              jmp short 0x82a8
00008286  803E6C0500        cmp byte [0x56c],0x0
0000828B  7503              jnz 0x8290
0000828D  E8BF4A            call 0xcd4f
00008290  C606990601        mov byte [0x699],0x1
00008295  C6066C0501        mov byte [0x56c],0x1
0000829A  E8901F            call 0xa22d            ; Get a random number.
0000829D  80E201            and dl,0x1
000082A0  7502              jnz 0x82a4
000082A2  B2FF              mov dl,0xff
000082A4  88169806          mov [0x698],dl
000082A8  A06E05            mov al,[0x56e]
000082AB  A26F05            mov [0x56f],al
000082AE  A09806            mov al,[0x698]
000082B1  A26E05            mov [0x56e],al
000082B4  A09906            mov al,[0x699]
000082B7  A27105            mov [0x571],al
000082BA  3C00              cmp al,0x0
000082BC  7503              jnz 0x82c1
000082BE  E9A300            jmp 0x8364
000082C1  803E710501        cmp byte [0x571],0x1
000082C6  7531              jnz 0x82f9
000082C8  803E7B05B4        cmp byte [0x57b],0xb4
000082CD  7212              jc 0x82e1
000082CF  C606710500        mov byte [0x571],0x0
000082D4  C606840500        mov byte [0x584],0x0
000082D9  C606990600        mov byte [0x699],0x0
000082DE  E98300            jmp 0x8364
000082E1  B401              mov ah,0x1
000082E3  B020              mov al,0x20
000082E5  C6065B0508        mov byte [0x55b],0x8
000082EA  803E500501        cmp byte [0x550],0x1
000082EF  7530              jnz 0x8321
000082F1  C606500500        mov byte [0x550],0x0
000082F6  EB29              jmp short 0x8321
000082F8  90                nop
000082F9  C6065B0500        mov byte [0x55b],0x0
000082FE  A17205            mov ax,[0x572]
00008301  8AD8              mov bl,al
00008303  3C02              cmp al,0x2
00008305  7602              jna 0x8309
00008307  2C02              sub al,0x2
00008309  A37205            mov [0x572],ax
0000830C  B408              mov ah,0x8
0000830E  8AC3              mov al,bl
00008310  340F              xor al,0xf
00008312  B104              mov cl,0x4
00008314  D2E0              shl al,cl
00008316  803E500501        cmp byte [0x550],0x1
0000831B  7504              jnz 0x8321
0000831D  FE065005          inc byte [0x550]
00008321  A27805            mov [0x578],al
00008324  88267605          mov [0x576],ah
00008328  C606770501        mov byte [0x577],0x1
0000832D  C6065C0500        mov byte [0x55c],0x0
00008332  8A1E6E05          mov bl,[0x56e]
00008336  FEC3              inc bl
00008338  D0E3              shl bl,1
0000833A  803E7105FF        cmp byte [0x571],0xff
0000833F  7403              jz 0x8344
00008341  80C306            add bl,0x6
00008344  2AFF              sub bh,bh
00008346  8B87AA0F          mov ax,[bx+0xfaa]
0000834A  A36905            mov [0x569],ax
0000834D  8B87B60F          mov ax,[bx+0xfb6]
00008351  A36705            mov [0x567],ax
00008354  C606E03900        mov byte [0x39e0],0x0
00008359  803E7C1200        cmp byte [0x127c],0x0
0000835E  7403              jz 0x8363
00008360  E8C549            call 0xcd28
00008363  C3                ret
00008364  833E040000        cmp word [0x4],byte +0x0
00008369  740A              jz 0x8375
0000836B  833E040007        cmp word [0x4],byte +0x7
00008370  7403              jz 0x8375
00008372  E80025            call 0xa875
00008375  E88100            call 0x83f9
00008378  8A167B05          mov dl,[0x57b]
0000837C  8B0E7905          mov cx,[0x579]
00008380  E85D1D            call 0xa0e0
00008383  A36305            mov [0x563],ax
00008386  A06E05            mov al,[0x56e]
00008389  0A067105          or al,[0x571]
0000838D  7504              jnz 0x8393
0000838F  E80701            call 0x8499
00008392  C3                ret
00008393  E8BA00            call 0x8450
00008396  891E5D05          mov [0x55d],bx
0000839A  E87602            call 0x8613
0000839D  E80A0C            call 0x8faa
000083A0  7214              jc 0x83b6
000083A2  E88011            call 0x9525
000083A5  720F              jc 0x83b6
000083A7  A16305            mov ax,[0x563]
000083AA  A35F05            mov [0x55f],ax
000083AD  C7066505030B      mov word [0x565],0xb03
000083B3  E8BF01            call 0x8575
000083B6  C3                ret
000083B7  B9030B            mov cx,0xb03
000083BA  2AC8              sub cl,al
000083BC  890E6505          mov [0x565],cx
000083C0  80FCFF            cmp ah,0xff
000083C3  7411              jz 0x83d6
000083C5  2AE4              sub ah,ah
000083C7  D0E0              shl al,1
000083C9  01065D05          add [0x55d],ax
000083CD  C70679050000      mov word [0x579],0x0
000083D3  EB0F              jmp short 0x83e4
000083D5  90                nop
000083D6  2AE4              sub ah,ah
000083D8  D0E0              shl al,1
000083DA  D0E0              shl al,1
000083DC  D0E0              shl al,1
000083DE  052801            add ax,0x128
000083E1  A37905            mov [0x579],ax
000083E4  1E                push ds
000083E5  07                pop es
000083E6  8B365D05          mov si,[0x55d]
000083EA  BF0E00            mov di,0xe
000083ED  B003              mov al,0x3
000083EF  E8AE1D            call 0xa1a0
000083F2  C7065D050E00      mov word [0x55d],0xe
000083F8  C3                ret
000083F9  C706F6050800      mov word [0x5f6],0x8
000083FF  C706F8052301      mov word [0x5f8],0x123
00008405  833E040007        cmp word [0x4],byte +0x7
0000840A  750C              jnz 0x8418
0000840C  C706F6052400      mov word [0x5f6],0x24
00008412  C706F8050F01      mov word [0x5f8],0x10f
00008418  A17905            mov ax,[0x579]
0000841B  803E6E0501        cmp byte [0x56e],0x1
00008420  722C              jc 0x844e
00008422  7513              jnz 0x8437
00008424  03067205          add ax,[0x572]
00008428  3B06F805          cmp ax,[0x5f8]
0000842C  721D              jc 0x844b
0000842E  A1F805            mov ax,[0x5f8]
00008431  48                dec ax
00008432  A37905            mov [0x579],ax
00008435  F9                stc
00008436  C3                ret
00008437  2B067205          sub ax,[0x572]
0000843B  7206              jc 0x8443
0000843D  3B06F605          cmp ax,[0x5f6]
00008441  7308              jnc 0x844b
00008443  A1F605            mov ax,[0x5f6]
00008446  A37905            mov [0x579],ax
00008449  F9                stc
0000844A  C3                ret
0000844B  A37905            mov [0x579],ax
0000844E  F8                clc
0000844F  C3                ret
00008450  A06E05            mov al,[0x56e]
00008453  3A066F05          cmp al,[0x56f]
00008457  7406              jz 0x845f
00008459  C70672050200      mov word [0x572],0x2
0000845F  833E720508        cmp word [0x572],byte +0x8
00008464  730F              jnc 0x8475
00008466  FE0E7705          dec byte [0x577]
0000846A  A07705            mov al,[0x577]
0000846D  2403              and al,0x3
0000846F  7504              jnz 0x8475
00008471  FF067205          inc word [0x572]
00008475  8A1E6B05          mov bl,[0x56b]
00008479  FEC3              inc bl
0000847B  80FB06            cmp bl,0x6
0000847E  7202              jc 0x8482
00008480  B300              mov bl,0x0
00008482  881E6B05          mov [0x56b],bl
00008486  803E6E05FF        cmp byte [0x56e],0xff
0000848B  7503              jnz 0x8490
0000848D  80C306            add bl,0x6
00008490  D0E3              shl bl,1
00008492  2AFF              sub bh,bh
00008494  8B9F7A0F          mov bx,[bx+0xf7a]
00008498  C3                ret
00008499  C70672050200      mov word [0x572],0x2
0000849F  C606770508        mov byte [0x577],0x8
000084A4  813E6105020C      cmp word [0x561],0xc02
000084AA  750B              jnz 0x84b7
000084AC  FE066D05          inc byte [0x56d]
000084B0  F6066D0507        test byte [0x56d],0x7
000084B5  7555              jnz 0x850c
000084B7  E85901            call 0x8613
000084BA  E8ED0A            call 0x8faa
000084BD  724D              jc 0x850c
000084BF  E86310            call 0x9525
000084C2  7248              jc 0x850c
000084C4  E8661D            call 0xa22d            ; Get a random number.
000084C7  8ADA              mov bl,dl
000084C9  81E30E00          and bx,0xe
000084CD  8BB7920F          mov si,[bx+0xf92]
000084D1  B800B8            mov ax,0xb800       ; Video memory.
000084D4  8EC0              mov es,ax           ;
000084D6  8B3E5F05          mov di,[0x55f]
000084DA  BDFA05            mov bp,0x5fa
000084DD  C7066105020C      mov word [0x561],0xc02
000084E3  B90206            mov cx,0x602
000084E6  E87C1C            call 0xa165
000084E9  E8411D            call 0xa22d            ; Get a random number.
000084EC  8ADA              mov bl,dl
000084EE  81E30600          and bx,0x6
000084F2  8BB7A20F          mov si,[bx+0xfa2]
000084F6  8B3E5F05          mov di,[0x55f]
000084FA  81C7F000          add di,0xf0
000084FE  BD1206            mov bp,0x612
00008501  B90206            mov cx,0x602
00008504  E85E1C            call 0xa165
00008507  C606830500        mov byte [0x583],0x0
0000850C  C3                ret
0000850D  C6065C0500        mov byte [0x55c],0x0
00008512  C606710501        mov byte [0x571],0x1
00008517  C606760502        mov byte [0x576],0x2
0000851C  C606780501        mov byte [0x578],0x1
00008521  C6067705FF        mov byte [0x577],0xff
00008526  C6066E0500        mov byte [0x56e],0x0
0000852B  C6065A0501        mov byte [0x55a],0x1
00008530  A1AC0F            mov ax,[0xfac]
00008533  A36905            mov [0x569],ax
00008536  A1B80F            mov ax,[0xfb8]
00008539  A36705            mov [0x567],ax
0000853C  C606500502        mov byte [0x550],0x2
00008541  C3                ret
00008542  8B0E7905          mov cx,[0x579]
00008546  8A167B05          mov dl,[0x57b]
0000854A  E8931B            call 0xa0e0
0000854D  A35F05            mov [0x55f],ax
00008550  E80100            call 0x8554
00008553  C3                ret

00008554  B81000            mov ax,0x10
00008557  8EC0              mov es,ax
00008559  BFFA05            mov di,0x5fa
0000855C  1E                push ds
0000855D  8B365F05          mov si,[0x55f]
00008561  B800B8            mov ax,0xb800
00008564  8ED8              mov ds,ax
00008566  268B0E6105        mov cx,[es:0x561]
0000856B  E88C1C            call 0xa1fa
0000856E  1F                pop ds
0000856F  C606830500        mov byte [0x583],0x0
00008574  C3                ret

00008575  B800B8            mov ax,0xb800
00008578  8EC0              mov es,ax
0000857A  8B3E5F05          mov di,[0x55f]
0000857E  BDFA05            mov bp,0x5fa
00008581  8B365D05          mov si,[0x55d]
00008585  8B0E6505          mov cx,[0x565]
00008589  890E6105          mov [0x561],cx
0000858D  C606830500        mov byte [0x583],0x0
00008592  E8D01B            call 0xa165
00008595  C3                ret

00008596  8A167B05          mov dl,[0x57b]
0000859A  8B0E7905          mov cx,[0x579]
0000859E  83E90C            sub cx,byte +0xc
000085A1  7302              jnc 0x85a5
000085A3  2BC9              sub cx,cx
000085A5  81F90F01          cmp cx,0x10f
000085A9  7203              jc 0x85ae
000085AB  B90E01            mov cx,0x10e
000085AE  E82F1B            call 0xa0e0
000085B1  A38105            mov [0x581],ax
000085B4  8BF8              mov di,ax
000085B6  B800B8            mov ax,0xb800    ; Video memory.
000085B9  8EC0              mov es,ax        ;
000085BB  BD0E00            mov bp,0xe
000085BE  BE7916            mov si,0x1679
000085C1  B90512            mov cx,0x1205
000085C4  E8351B            call 0xa0fc
000085C7  2AE4              sub ah,ah
000085C9  CD1A              int 0x1a
000085CB  89167F05          mov [0x57f],dx
000085CF  C7063C5A0000      mov word [0x5a3c],0x0
000085D5  C7063E5A0000      mov word [0x5a3e],0x0
000085DB  E86E48            call 0xce4c
000085DE  2AE4              sub ah,ah
000085E0  CD1A              int 0x1a
000085E2  2B167F05          sub dx,[0x57f]
000085E6  83FA0A            cmp dx,byte +0xa
000085E9  72F0              jc 0x85db
000085EB  E86349            call 0xcf51			; Turn off the PC-Speaker.
000085EE  8B3E8105          mov di,[0x581]		; Draws the unknown sprite.
000085F2  BE0E00            mov si,0xe			;
000085F5  B90512            mov cx,0x1205		;
000085F8  C606830500        mov byte [0x583],0x0	;
000085FD  E8CD1B            call 0xa1cd			;
00008600  803E781600        cmp byte [0x1678],0x0
00008605  740B              jz 0x8612
00008607  803E801F00        cmp byte [0x1f80],0x0   ; Remove a life if any remain.
0000860C  7404              jz 0x8612               ;
0000860E  FE0E801F          dec byte [0x1f80]       ;
00008612  C3                ret

00008613  B800B8            mov ax,0xb800	; Draws the unknown sprite.
00008616  8EC0              mov es,ax           ;
00008618  8B3E5F05          mov di,[0x55f]	;
0000861C  BEFA05            mov si,0x5fa	;
0000861F  8B0E6105          mov cx,[0x561]	;
00008623  E8A71B            call 0xa1cd		;
00008626  C3                ret

00008627  0000              add [bx+si],al
00008629  0000              add [bx+si],al
0000862B  0000              add [bx+si],al
0000862D  0000              add [bx+si],al
0000862F  002A              add [bp+si],ch
00008631  E4CD              in al,0xcd
00008633  1A8BC22B          sbb cl,[bp+di+0x2bc2]
00008637  06                push es
00008638  9F                lahf
00008639  06                push es
0000863A  3D0200            cmp ax,0x2
0000863D  7301              jnc 0x8640
0000863F  C3                ret

00008640  89169F06          mov [0x69f],dx
00008644  803E9B0600        cmp byte [0x69b],0x0
00008649  7513              jnz 0x865e
0000864B  E8A300            call 0x86f1
0000864E  E89601            call 0x87e7
00008651  8BD0              mov dx,ax
00008653  E89101            call 0x87e7
00008656  2BC2              sub ax,dx
00008658  3DEDF8            cmp ax,0xf8ed
0000865B  72F6              jc 0x8653
0000865D  C3                ret

0000865E  BA0102            mov dx,0x201
00008661  EC                in al,dx
00008662  2410              and al,0x10
00008664  A29A06            mov [0x69a],al
00008667  C6069E0603        mov byte [0x69e],0x3
0000866C  E87801            call 0x87e7
0000866F  A39C06            mov [0x69c],ax
00008672  EE                out dx,al
00008673  B9D007            mov cx,0x7d0
00008676  EC                in al,dx
00008677  A801              test al,0x1
00008679  7513              jnz 0x868e
0000867B  F6069E0601        test byte [0x69e],0x1
00008680  740C              jz 0x868e
00008682  80269E06FE        and byte [0x69e],0xfe
00008687  E84700            call 0x86d1
0000868A  881E9806          mov [0x698],bl
0000868E  A802              test al,0x2
00008690  7513              jnz 0x86a5
00008692  F6069E0602        test byte [0x69e],0x2
00008697  740C              jz 0x86a5
00008699  80269E06FD        and byte [0x69e],0xfd
0000869E  E83000            call 0x86d1
000086A1  881E9906          mov [0x699],bl
000086A5  F6069E0603        test byte [0x69e],0x3
000086AA  7424              jz 0x86d0
000086AC  E83801            call 0x87e7
000086AF  2B069C06          sub ax,[0x69c]
000086B3  3D6419            cmp ax,0x1964
000086B6  E0BE              loopne 0x8676
000086B8  F6069E0601        test byte [0x69e],0x1
000086BD  7405              jz 0x86c4
000086BF  C6069806FF        mov byte [0x698],0xff
000086C4  F6069E0602        test byte [0x69e],0x2
000086C9  7405              jz 0x86d0
000086CB  C6069906FF        mov byte [0x699],0xff
000086D0  C3                ret

000086D1  50                push ax
000086D2  E81201            call 0x87e7
000086D5  2B069C06          sub ax,[0x69c]
000086D9  8BD8              mov bx,ax
000086DB  58                pop ax
000086DC  81FBE6F5          cmp bx,0xf5e6
000086E0  7303              jnc 0x86e5
000086E2  B301              mov bl,0x1
000086E4  C3                ret
000086E5  81FBFAFA          cmp bx,0xfafa
000086E9  7303              jnc 0x86ee
000086EB  2ADB              sub bl,bl
000086ED  C3                ret

000086EE  B3FF              mov bl,0xff
000086F0  C3                ret

000086F1  A0BA06            mov al,[0x6ba]
000086F4  803E9706FD        cmp byte [0x697],0xfd	; Do PCJr stuff.
000086F9  7408              jz 0x8703                   ;
000086FB  2206BD06          and al,[0x6bd]		;
000086FF  2206BE06          and al,[0x6be]		;
00008703  3480              xor al,0x80
00008705  7402              jz 0x8709			
00008707  B001              mov al,0x1
00008709  A29906            mov [0x699],al
0000870C  A0B806            mov al,[0x6b8]
0000870F  803E9706FD        cmp byte [0x697],0xfd	; Do PCJr stuff.
00008714  7408              jz 0x871e			;
00008716  2206BC06          and al,[0x6bc]		;
0000871A  2206BF06          and al,[0x6bf]		;
0000871E  3480              xor al,0x80
00008720  7405              jz 0x8727
00008722  C6069906FF        mov byte [0x699],0xff
00008727  A0B906            mov al,[0x6b9]
0000872A  803E9706FD        cmp byte [0x697],0xfd      ; Do PCJr stuff.
0000872F  7408              jz 0x8739	               ;
00008731  2206BC06          and al,[0x6bc]             ;
00008735  2206BD06          and al,[0x6bd]             ;
00008739  3480              xor al,0x80 
0000873B  7402              jz 0x873f
0000873D  B001              mov al,0x1
0000873F  A29806            mov [0x698],al
00008742  A0BB06            mov al,[0x6bb]
00008745  803E9706FD        cmp byte [0x697],0xfd     ; Do PCJr stuff.
0000874A  7408              jz 0x8754                 ;
0000874C  2206BE06          and al,[0x6be]            ;
00008750  2206BF06          and al,[0x6bf]            ;
00008754  3480              xor al,0x80
00008756  7405              jz 0x875d
00008758  C6069806FF        mov byte [0x698],0xff
0000875D  A0B706            mov al,[0x6b7]
00008760  B103              mov cl,0x3
00008762  D2E8              shr al,cl
00008764  A29A06            mov [0x69a],al
00008767  C3                ret

00008768  A19306            mov ax,[0x693]
0000876B  3B069106          cmp ax,[0x691]
0000876F  7416              jz 0x8787
00008771  A39106            mov [0x691],ax
00008774  F606C00680        test byte [0x6c0],0x80
00008779  750D              jnz 0x8788
0000877B  A19306            mov ax,[0x693]
0000877E  3B06006E          cmp ax,[0x6e00]
00008782  7403              jz 0x8787
00008784  E8194B            call 0xd2a0
00008787  C3                ret

00008788  F606C90680        test byte [0x6c9],0x80
0000878D  7401              jz 0x8790
0000878F  C3                ret

00008790  F606CC0680        test byte [0x6cc],0x80
00008795  7506              jnz 0x879d
00008797  C606801F09        mov byte [0x1f80],0x9       ; Cheat to gain 9 lives.
0000879C  C3                ret

0000879D  F606C10680        test byte [0x6c1],0x80
000087A2  7431              jz 0x87d5
000087A4  F606CB0680        test byte [0x6cb],0x80
000087A9  7506              jnz 0x87b1
000087AB  C6061C04FF        mov byte [0x41c],0xff	; Set game over flag to on.
000087B0  C3                ret

000087B1  F606C80680        test byte [0x6c8],0x80
000087B6  7506              jnz 0x87be
000087B8  C6061B04FF        mov byte [0x41b],0xff
000087BD  C3                ret

000087BE  F606C70680        test byte [0x6c7],0x80
000087C3  750F              jnz 0x87d4
000087C5  F6160000          not byte [0x0]
000087C9  803E000000        cmp byte [0x0],0x0
000087CE  7503              jnz 0x87d3
000087D0  E87E47            call 0xcf51		; Turn off the PC-Speaker.
000087D3  C3                ret

000087D4  C3                ret

000087D5  E8D700            call 0x88af
000087D8  58                pop ax
000087D9  CB                retf

000087DA  B800F0            mov ax,0xf000        ; [0x697] = MACHINE ID.
000087DD  8EC0              mov es,ax            ;
000087DF  26A0FEFF          mov al,[es:0xfffe]   ;
000087E3  A29706            mov [0x697],al       ;
000087E6  C3                ret                  ;

000087E7  B000              mov al,0x0
000087E9  E643              out 0x43,al
000087EB  90                nop
000087EC  90                nop
000087ED  E440              in al,0x40
000087EF  8AE0              mov ah,al
000087F1  90                nop
000087F2  E440              in al,0x40
000087F4  86C4              xchg al,ah
000087F6  C3                ret

000087F7  E8EDFF            call 0x87e7
000087FA  8BD8              mov bx,ax
000087FC  2BC1              sub ax,cx
000087FE  8BCB              mov cx,bx
00008800  3BC2              cmp ax,dx
00008802  7301              jnc 0x8805
00008804  C3                ret
00008805  3BD2              cmp dx,dx
00008807  C3                ret

00008808  BADA03            mov dx,0x3da        ; Vertical retrace.
0000880B  EC                in al,dx            ;
0000880C  2408              and al,0x8          ;
0000880E  C3                ret                 ;

; This procedure initializes the PCJr video parameters.
00008818  50                push ax
00008819  06                push es
0000881A  57                push di
0000881B  51                push cx
0000881C  B81000            mov ax,0x10
0000881F  8EC0              mov es,ax
00008821  FC                cld
00008822  BFB706            mov di,0x6b7
00008825  B91600            mov cx,0x16
00008828  B080              mov al,0x80
0000882A  F3AA              rep stosb
0000882C  26A19306          mov ax,[es:0x693]
00008830  2D7000            sub ax,0x70
00008833  26A39106          mov [es:0x691],ax
00008837  B84000            mov ax,0x40          ; PCJr only.
0000883A  8EC0              mov es,ax            ;
0000883C  26A01200          mov al,[es:0x12]     ;
00008840  2EA2E713          mov [cs:0x13e7],al   ;
00008844  59                pop cx
00008845  5F                pop di
00008846  07                pop es
00008847  58                pop ax
00008848  C3                ret

; Note: int 48h is for "Cordless Keyboard Translation" - PCjr only.
00008849  2BC0              sub ax,ax                    ; Interrupt vector table.
0000884B  8EC0              mov es,ax                    ;
0000884D  26A12400          mov ax,[es:0x24]             ; Copy system timer vector to registers.
00008851  268B1E2600        mov bx,[es:0x26]		 ; 
00008856  268B0E2001        mov cx,[es:0x120]            ; Copy int 48h vector to registers.
0000885B  268B162201        mov dx,[es:0x122]            ;
00008860  2EA3DF13          mov [cs:0x13df],ax           ; Copy the vectors to the program's memory area.
00008864  2E891EE113        mov [cs:0x13e1],bx           ;
00008869  2E890EE313        mov [cs:0x13e3],cx           ;
0000886E  2E8916E513        mov [cs:0x13e5],dx           ;
00008873  BBB314            mov bx,0x14b3                ; Custom keyboard interrupt vector.
00008876  803E9706FD        cmp byte [0x697],0xfd        ; Use a different custom keyboard interrupt vector for PCJr.
0000887B  7503              jnz 0x8880                   ;
0000887D  BBFB14            mov bx,0x14fb                ;
00008880  FA                cli                          ; Disable hardware interrupts.
00008881  26891E2400        mov [es:0x24],bx             ; Set custom keyboard interrupt.
00008886  268C0E2600        mov [es:0x26],cs             ;
0000888B  803E9706FD        cmp byte [0x697],0xfd	 ; Set custom interrupt 48h for pcjr.
00008890  751B              jnz 0x88ad                   ;
00008892  26C70620015415    mov word [es:0x120],0x1554   ;
00008899  268C0E2201        mov [es:0x122],cs            ;
0000889E  B84000            mov ax,0x40                  ; Modify keyboard flags byte 1.
000088A1  8EC0              mov es,ax                    ;
000088A3  26A01800          mov al,[es:0x18]             ;
000088A7  0C01              or al,0x1                    ;
000088A9  26A21800          mov [es:0x18],al             ;
000088AD  FB                sti                          ; Enable hardware interrupts.
000088AE  C3                ret

000088AF  2BC0              sub ax,ax
000088B1  8EC0              mov es,ax
000088B3  2EA1DF13          mov ax,[cs:0x13df]
000088B7  2E8B1EE113        mov bx,[cs:0x13e1]
000088BC  2E8B0EE313        mov cx,[cs:0x13e3]
000088C1  2E8B16E513        mov dx,[cs:0x13e5]
000088C6  FA                cli
000088C7  26A32400          mov [es:0x24],ax
000088CB  26891E2600        mov [es:0x26],bx
000088D0  803E9706FD        cmp byte [0x697],0xfd	     ; Check for PCJr.
000088D5  750A              jnz 0x88e1
000088D7  26890E2001        mov [es:0x120],cx
000088DC  2689162201        mov [es:0x122],dx
000088E1  FB                sti
000088E2  C3                ret

; Custom keyboard interrupt handler.
000088E3  50                push ax
000088E4  06                push es
000088E5  57                push di
000088E6  51                push cx
000088E7  BF1000            mov di,0x10		  ; Set ES to 0x10.
000088EA  8EC7              mov es,di             ;
000088EC  E460              in al,0x60            ; Read the keyboard.
000088EE  8AE0              mov ah,al             ; ah = al
000088F0  247F              and al,0x7f           ; Remove pressed/unpressed bit.
000088F2  F6C480            test ah,0x80          ; Check whether the key has been pressed.
000088F5  7505              jnz 0x88fc            ; Increase [es:0x693] if a key is being pressed.
000088F7  26FF069306        inc word [es:0x693]   ;
000088FC  BFA106            mov di,0x6a1          ; Scan a table of keycodes.
000088FF  B91600            mov cx,0x16           ;
00008902  FC                cld                   ;
00008903  F2AE              repne scasb           ;
00008905  750C              jnz 0x8913            ; Save the key that has been read if it matches a table entry. Each key is saved in its own slot.
00008907  81EFA206          sub di,0x6a2          ;
0000890B  80E480            and ah,0x80           ;
0000890E  2688A5B706        mov [es:di+0x6b7],ah  ;
00008913  E461              in al,0x61		  ; Reset the keyboard controller.
00008915  8AE0              mov ah,al             ;
00008917  0C80              or al,0x80            ;
00008919  E661              out 0x61,al           ;
0000891B  8AC4              mov al,ah             ;
0000891D  E661              out 0x61,al           ;
0000891F  E88000            call 0x89a2
00008922  59                pop cx
00008923  5F                pop di
00008924  07                pop es
00008925  B020              mov al,0x20		  ; Send EOI to PIC.
00008927  E620              out 0x20,al		  ;
00008929  58                pop ax
0000892A  CF                iret

; Likely a keyboard handler for the PCJr.
0000892B  FB                sti
0000892C  50                push ax
0000892D  06                push es
0000892E  57                push di
0000892F  51                push cx
00008930  BF1000            mov di,0x10
00008933  8EC7              mov es,di
00008935  8AE0              mov ah,al
00008937  247F              and al,0x7f
00008939  F6C480            test ah,0x80
0000893C  7505              jnz 0x8943
0000893E  26FF069306        inc word [es:0x693]
00008943  80FCFF            cmp ah,0xff
00008946  7418              jz 0x8960
00008948  80FC55            cmp ah,0x55
0000894B  7413              jz 0x8960
0000894D  06                push es
0000894E  BF4000            mov di,0x40
00008951  8EC7              mov es,di
00008953  268A0E1200        mov cl,[es:0x12]
00008958  07                pop es
00008959  2E3A0EE713        cmp cl,[cs:0x13e7]
0000895E  7405              jz 0x8965
00008960  E8B5FE            call 0x8818              ; Set up PCJr video parameters.
00008963  EB17              jmp short 0x897c
00008965  BFA106            mov di,0x6a1
00008968  B91600            mov cx,0x16
0000896B  FC                cld
0000896C  F2AE              repne scasb
0000896E  750C              jnz 0x897c
00008970  81EFA206          sub di,0x6a2
00008974  80E480            and ah,0x80
00008977  2688A5B706        mov [es:di+0x6b7],ah
0000897C  E82300            call 0x89a2
0000897F  59                pop cx
00008980  5F                pop di
00008981  07                pop es
00008982  58                pop ax
00008983  CF                iret

; PCJr INT 48h keyboard handler.
00008984  CD09              int 0x9
00008986  CF                iret

00008987  B800F0            mov ax,0xf000
0000898A  8ED0              mov ss,ax
0000898C  B84000            mov ax,0x40
0000898F  8ED8              mov ds,ax
00008991  BB7200            mov bx,0x72
00008994  C7073412          mov word [bx],0x1234
00008998  B80000            mov ax,0x0
0000899B  8EC0              mov es,ax
0000899D  EA5BE000F0        jmp 0xf000:0xe05b   ; Soft reboot.
000089A2  26A0C906          mov al,[es:0x6c9]
000089A6  260A06B706        or al,[es:0x6b7]
000089AB  3C00              cmp al,0x0
000089AD  754A              jnz 0x89f9
000089AF  26F606CA0680      test byte [es:0x6ca],0x80
000089B5  7506              jnz 0x89bd
000089B7  B020              mov al,0x20
000089B9  E620              out 0x20,al
000089BB  EBCA              jmp short 0x8987
000089BD  26F606B90680      test byte [es:0x6b9],0x80
000089C3  750F              jnz 0x89d4
000089C5  26803E900601      cmp byte [es:0x690],0x1
000089CB  722C              jc 0x89f9
000089CD  26FE0E9006        dec byte [es:0x690]
000089D2  EB15              jmp short 0x89e9
000089D4  26F606BB0680      test byte [es:0x6bb],0x80
000089DA  751D              jnz 0x89f9
000089DC  26803E900607      cmp byte [es:0x690],0x7
000089E2  7315              jnc 0x89f9
000089E4  26FE069006        inc byte [es:0x690]
000089E9  52                push dx
000089EA  B002              mov al,0x2
000089EC  BAD403            mov dx,0x3d4
000089EF  EE                out dx,al
000089F0  26A09006          mov al,[es:0x690]
000089F4  0427              add al,0x27
000089F6  42                inc dx
000089F7  EE                out dx,al
000089F8  5A                pop dx
000089F9  C3                ret

000089FA  0000              add [bx+si],al
000089FC  0000              add [bx+si],al
000089FE  0000              add [bx+si],al
00008A00  8B1E0800          mov bx,[0x8]
00008A04  8A8F0E10          mov cl,[bx+0x100e]
00008A08  E82218            call 0xa22d            ; Get a random number.
00008A0B  80E207            and dl,0x7
00008A0E  3AD1              cmp dl,cl
00008A10  77F6              ja 0x8a08
00008A12  02970610          add dl,[bx+0x1006]
00008A16  3A162810          cmp dl,[0x1028]
00008A1A  74EC              jz 0x8a08
00008A1C  88162810          mov [0x1028],dl
00008A20  8ADA              mov bl,dl
00008A22  8A8FF00F          mov cl,[bx+0xff0]
00008A26  B288              mov dl,0x88
00008A28  F6C180            test cl,0x80
00008A2B  7502              jnz 0x8a2f
00008A2D  B290              mov dl,0x90
00008A2F  81E17F00          and cx,0x7f
00008A33  D1E1              shl cx,1
00008A35  D1E1              shl cx,1
00008A37  C3                ret
00008A38  833E040007        cmp word [0x4],byte +0x7
00008A3D  7504              jnz 0x8a43
00008A3F  E8E81A            call 0xa52a
00008A42  C3                ret
00008A43  833E040000        cmp word [0x4],byte +0x0
00008A48  7404              jz 0x8a4e
00008A4A  E8A900            call 0x8af6
00008A4D  C3                ret
00008A4E  A07B05            mov al,[0x57b]
00008A51  24F8              and al,0xf8
00008A53  3C60              cmp al,0x60
00008A55  7409              jz 0x8a60
00008A57  E82D00            call 0x8a87
00008A5A  722A              jc 0x8a86
00008A5C  E87E01            call 0x8bdd
00008A5F  C3                ret
00008A60  803E500502        cmp byte [0x550],0x2
00008A65  731E              jnc 0x8a85
00008A67  A27B05            mov [0x57b],al
00008A6A  0432              add al,0x32
00008A6C  A27C05            mov [0x57c],al
00008A6F  803E500501        cmp byte [0x550],0x1
00008A74  740D              jz 0x8a83
00008A76  C606500501        mov byte [0x550],0x1
00008A7B  2AE4              sub ah,ah
00008A7D  CD1A              int 0x1a
00008A7F  89165605          mov [0x556],dx
00008A83  F9                stc
00008A84  C3                ret
00008A85  F8                clc
00008A86  C3                ret
00008A87  8A0E7B05          mov cl,[0x57b]
00008A8B  80C102            add cl,0x2
00008A8E  80E1F8            and cl,0xf8
00008A91  8B1E0800          mov bx,[0x8]
00008A95  8A9F0610          mov bl,[bx+0x1006]
00008A99  8A87F00F          mov al,[bx+0xff0]
00008A9D  3C00              cmp al,0x0
00008A9F  7507              jnz 0x8aa8
00008AA1  C6067C1200        mov byte [0x127c],0x0
00008AA6  F8                clc
00008AA7  C3                ret
00008AA8  43                inc bx
00008AA9  B588              mov ch,0x88
00008AAB  A880              test al,0x80
00008AAD  7502              jnz 0x8ab1
00008AAF  B590              mov ch,0x90
00008AB1  3ACD              cmp cl,ch
00008AB3  75E4              jnz 0x8a99
00008AB5  257F00            and ax,0x7f
00008AB8  D1E0              shl ax,1
00008ABA  D1E0              shl ax,1
00008ABC  8B167905          mov dx,[0x579]
00008AC0  81E2F8FF          and dx,0xfff8
00008AC4  3BD0              cmp dx,ax
00008AC6  72D1              jc 0x8a99
00008AC8  8B167905          mov dx,[0x579]
00008ACC  83EA0F            sub dx,byte +0xf
00008ACF  81E2F8FF          and dx,0xfff8
00008AD3  3BD0              cmp dx,ax
00008AD5  77C2              ja 0x8a99
00008AD7  80ED02            sub ch,0x2
00008ADA  882E7B05          mov [0x57b],ch
00008ADE  80C532            add ch,0x32
00008AE1  882E7C05          mov [0x57c],ch
00008AE5  803E7C1200        cmp byte [0x127c],0x0
00008AEA  7508              jnz 0x8af4
00008AEC  C6067C1201        mov byte [0x127c],0x1
00008AF1  E84A42            call 0xcd3e
00008AF4  F9                stc
00008AF5  C3                ret
00008AF6  C606E03900        mov byte [0x39e0],0x0
00008AFB  803E710501        cmp byte [0x571],0x1
00008B00  752A              jnz 0x8b2c
00008B02  A15026            mov ax,[0x2650]
00008B05  2D0400            sub ax,0x4
00008B08  8A165226          mov dl,[0x2652]
00008B0C  80EA08            sub dl,0x8
00008B0F  BE0C00            mov si,0xc
00008B12  8B1E7905          mov bx,[0x579]
00008B16  8A367B05          mov dh,[0x57b]
00008B1A  BF1800            mov di,0x18
00008B1D  B9100E            mov cx,0xe10
00008B20  E83617            call 0xa259
00008B23  7307              jnc 0x8b2c
00008B25  C606510501        mov byte [0x551],0x1
00008B2A  F8                clc
00008B2B  C3                ret
00008B2C  833E040003        cmp word [0x4],byte +0x3
00008B31  750B              jnz 0x8b3e
00008B33  E83D25            call 0xb073
00008B36  7306              jnc 0x8b3e
00008B38  C6065C0501        mov byte [0x55c],0x1
00008B3D  C3                ret
00008B3E  8A0E7B05          mov cl,[0x57b]
00008B42  80E1F8            and cl,0xf8
00008B45  8B1E0400          mov bx,[0x4]
00008B49  D1E3              shl bx,1
00008B4B  8B9F6912          mov bx,[bx+0x1269]
00008B4F  8AAF2910          mov ch,[bx+0x1029]
00008B53  80FD00            cmp ch,0x0
00008B56  7502              jnz 0x8b5a
00008B58  F8                clc
00008B59  C3                ret
00008B5A  8A878910          mov al,[bx+0x1089]
00008B5E  A27B12            mov [0x127b],al
00008B61  D0E3              shl bl,1
00008B63  8B87A911          mov ax,[bx+0x11a9]
00008B67  A37912            mov [0x1279],ax
00008B6A  8B87E910          mov ax,[bx+0x10e9]
00008B6E  D0EB              shr bl,1
00008B70  43                inc bx
00008B71  3ACD              cmp cl,ch
00008B73  75DA              jnz 0x8b4f
00008B75  8B167905          mov dx,[0x579]
00008B79  81E2F8FF          and dx,0xfff8
00008B7D  3BD0              cmp dx,ax
00008B7F  72CE              jc 0x8b4f
00008B81  8B167905          mov dx,[0x579]
00008B85  2B167912          sub dx,[0x1279]
00008B89  7302              jnc 0x8b8d
00008B8B  2BD2              sub dx,dx
00008B8D  81E2FCFF          and dx,0xfffc
00008B91  3BD0              cmp dx,ax
00008B93  77BA              ja 0x8b4f
00008B95  882E7B05          mov [0x57b],ch
00008B99  80C532            add ch,0x32
00008B9C  882E7C05          mov [0x57c],ch
00008BA0  A07B12            mov al,[0x127b]
00008BA3  A25C05            mov [0x55c],al
00008BA6  3C00              cmp al,0x0
00008BA8  7406              jz 0x8bb0
00008BAA  81267905FCFF      and word [0x579],0xfffc
00008BB0  833E040004        cmp word [0x4],byte +0x4
00008BB5  7510              jnz 0x8bc7
00008BB7  4B                dec bx
00008BB8  83EB27            sub bx,byte +0x27
00008BBB  720A              jc 0x8bc7
00008BBD  83FB10            cmp bx,byte +0x10
00008BC0  7305              jnc 0x8bc7
00008BC2  43                inc bx
00008BC3  881EE039          mov [0x39e0],bl
00008BC7  F9                stc
00008BC8  C3                ret
00008BC9  B103              mov cl,0x3
00008BCB  D3EB              shr bx,cl
00008BCD  8AEB              mov ch,bl
00008BCF  B103              mov cl,0x3
00008BD1  D3EB              shr bx,cl
00008BD3  8ACD              mov cl,ch
00008BD5  80E107            and cl,0x7
00008BD8  B580              mov ch,0x80
00008BDA  D2ED              shr ch,cl
00008BDC  C3                ret
00008BDD  8A167B05          mov dl,[0x57b]
00008BE1  80E2F8            and dl,0xf8
00008BE4  2BDB              sub bx,bx
00008BE6  80FA08            cmp dl,0x8
00008BE9  740E              jz 0x8bf9
00008BEB  FEC3              inc bl
00008BED  80FA28            cmp dl,0x28
00008BF0  7407              jz 0x8bf9
00008BF2  FEC3              inc bl
00008BF4  80FA48            cmp dl,0x48
00008BF7  7547              jnz 0x8c40
00008BF9  A17905            mov ax,[0x579]
00008BFC  3B1E2F05          cmp bx,[0x52f]
00008C00  752A              jnz 0x8c2c
00008C02  803E250503        cmp byte [0x525],0x3
00008C07  7723              ja 0x8c2c
00008C09  80FB01            cmp bl,0x1
00008C0C  7410              jz 0x8c1e
00008C0E  B90400            mov cx,0x4
00008C11  2A0E2505          sub cl,[0x525]
00008C15  D0E1              shl cl,1
00008C17  D0E1              shl cl,1
00008C19  03C1              add ax,cx
00008C1B  EB0F              jmp short 0x8c2c
00008C1D  90                nop
00008C1E  2AED              sub ch,ch
00008C20  8A0E2505          mov cl,[0x525]
00008C24  FEC1              inc cl
00008C26  D0E1              shl cl,1
00008C28  D0E1              shl cl,1
00008C2A  2BC1              sub ax,cx
00008C2C  8A9F2510          mov bl,[bx+0x1025]
00008C30  8BF3              mov si,bx
00008C32  8BD8              mov bx,ax
00008C34  83C30A            add bx,byte +0xa
00008C37  E88FFF            call 0x8bc9
00008C3A  84A81610          test [bx+si+0x1016],ch
00008C3E  7502              jnz 0x8c42
00008C40  F8                clc
00008C41  C3                ret
00008C42  88167B05          mov [0x57b],dl
00008C46  80C232            add dl,0x32
00008C49  88167C05          mov [0x57c],dl
00008C4D  81267905F8FF      and word [0x579],0xfff8
00008C53  C6065C0501        mov byte [0x55c],0x1
00008C58  F9                stc
00008C59  C3                ret

00008C60  C606651600        mov byte [0x1665],0x0
00008C65  C606731600        mov byte [0x1673],0x0
00008C6A  C606771600        mov byte [0x1677],0x0
00008C6F  C606781600        mov byte [0x1678],0x0
00008C74  C7066C160900      mov word [0x166c],0x9
00008C7A  C3                ret

00008C7B  803E731600        cmp byte [0x1673],0x0
00008C80  740A              jz 0x8c8c
00008C82  2AE4              sub ah,ah
00008C84  CD1A              int 0x1a
00008C86  3B16EC17          cmp dx,[0x17ec]
00008C8A  7501              jnz 0x8c8d
00008C8C  C3                ret
00008C8D  8916EC17          mov [0x17ec],dx
00008C91  803E771600        cmp byte [0x1677],0x0
00008C96  7417              jz 0x8caf
00008C98  A17116            mov ax,[0x1671]
00008C9B  25F8FF            and ax,0xfff8
00008C9E  8B1E7905          mov bx,[0x579]
00008CA2  81E3F8FF          and bx,0xfff8
00008CA6  3BC3              cmp ax,bx
00008CA8  7505              jnz 0x8caf
00008CAA  C606741600        mov byte [0x1674],0x0
00008CAF  FE06E917          inc byte [0x17e9]
00008CB3  833EEA1701        cmp word [0x17ea],byte +0x1
00008CB8  7704              ja 0x8cbe
00008CBA  FF0EEA17          dec word [0x17ea]
00008CBE  A17116            mov ax,[0x1671]
00008CC1  8B16EA17          mov dx,[0x17ea]
00008CC5  B103              mov cl,0x3
00008CC7  D2EA              shr dl,cl
00008CC9  803E741601        cmp byte [0x1674],0x1
00008CCE  7215              jc 0x8ce5
00008CD0  750D              jnz 0x8cdf
00008CD2  03C2              add ax,dx
00008CD4  3D2F01            cmp ax,0x12f
00008CD7  720C              jc 0x8ce5
00008CD9  B82E01            mov ax,0x12e
00008CDC  EB07              jmp short 0x8ce5
00008CDE  90                nop
00008CDF  2BC2              sub ax,dx
00008CE1  7302              jnc 0x8ce5
00008CE3  2BC0              sub ax,ax
00008CE5  A37116            mov [0x1671],ax
00008CE8  8B1EDF17          mov bx,[0x17df]
00008CEC  A0E917            mov al,[0x17e9]
00008CEF  D0E8              shr al,1
00008CF1  02067316          add al,[0x1673]
00008CF5  8AD0              mov dl,al
00008CF7  2A067616          sub al,[0x1676]
00008CFB  7214              jc 0x8d11
00008CFD  2AF8              sub bh,al
00008CFF  7402              jz 0x8d03
00008D01  730E              jnc 0x8d11
00008D03  C606731600        mov byte [0x1673],0x0
00008D08  C606781600        mov byte [0x1678],0x0
00008D0D  E84200            call 0x8d52
00008D10  C3                ret
00008D11  88167316          mov [0x1673],dl
00008D15  8B0E7116          mov cx,[0x1671]
00008D19  891EE117          mov [0x17e1],bx
00008D1D  E8C013            call 0xa0e0
00008D20  A3E717            mov [0x17e7],ax
00008D23  803EE91702        cmp byte [0x17e9],0x2
00008D28  7403              jz 0x8d2d
00008D2A  E82500            call 0x8d52
00008D2D  E87A02            call 0x8faa
00008D30  72DE              jc 0x8d10
00008D32  8B3EE717          mov di,[0x17e7]
00008D36  893EE517          mov [0x17e5],di
00008D3A  8B0EE117          mov cx,[0x17e1]
00008D3E  890EE317          mov [0x17e3],cx
00008D42  B800B8            mov ax,0xb800
00008D45  8EC0              mov es,ax
00008D47  8B36DD17          mov si,[0x17dd]
00008D4B  BDEE17            mov bp,0x17ee
00008D4E  E8AB13            call 0xa0fc
00008D51  C3                ret

00008D52  B800B8            mov ax,0xb800	; Draws the sprite.
00008D55  8EC0              mov es,ax		;
00008D57  8B3EE517          mov di,[0x17e5]	;
00008D5B  BEEE17            mov si,0x17ee	;
00008D5E  8B0EE317          mov cx,[0x17e3]	;
00008D62  E86814            call 0xa1cd		;
00008D65  C3                ret

00008D66  FE0E6A16          dec byte [0x166a]
00008D6A  7401              jz 0x8d6d
00008D6C  C3                ret
00008D6D  C6066A160D        mov byte [0x166a],0xd
00008D72  E893FA            call 0x8808   ; Get vertical retrace status.
00008D75  75F5              jnz 0x8d6c
00008D77  803E651600        cmp byte [0x1665],0x0
00008D7C  7403              jz 0x8d81
00008D7E  E8B401            call 0x8f35
00008D81  803E731600        cmp byte [0x1673],0x0
00008D86  75E4              jnz 0x8d6c
00008D88  803E651600        cmp byte [0x1665],0x0
00008D8D  756E              jnz 0x8dfd
00008D8F  803E7B0560        cmp byte [0x57b],0x60
00008D94  77D6              ja 0x8d6c
00008D96  C606771600        mov byte [0x1677],0x0
00008D9B  803E500501        cmp byte [0x550],0x1
00008DA0  7518              jnz 0x8dba
00008DA2  803E180400        cmp byte [0x418],0x0
00008DA7  7511              jnz 0x8dba
00008DA9  2AE4              sub ah,ah
00008DAB  CD1A              int 0x1a
00008DAD  2B165605          sub dx,[0x556]
00008DB1  83FA48            cmp dx,byte +0x48
00008DB4  7204              jc 0x8dba
00008DB6  FE067716          inc byte [0x1677]
00008DBA  E87014            call 0xa22d            ; Get a random number.
00008DBD  803E771600        cmp byte [0x1677],0x0
00008DC2  7406              jz 0x8dca
00008DC4  80E203            and dl,0x3
00008DC7  EB09              jmp short 0x8dd2
00008DC9  90                nop
00008DCA  80E20F            and dl,0xf
00008DCD  80FA0C            cmp dl,0xc
00008DD0  739A              jnc 0x8d6c
00008DD2  88166916          mov [0x1669],dl
00008DD6  E84101            call 0x8f1a
00008DD9  890E6616          mov [0x1666],cx
00008DDD  88166816          mov [0x1668],dl
00008DE1  E85101            call 0x8f35
00008DE4  72D4              jc 0x8dba
00008DE6  C60665161D        mov byte [0x1665],0x1d
00008DEB  8B1E0800          mov bx,[0x8]
00008DEF  D0E3              shl bl,1
00008DF1  8B871E18          mov ax,[bx+0x181e]
00008DF5  A36C16            mov [0x166c],ax
00008DF8  C606701601        mov byte [0x1670],0x1
00008DFD  E83501            call 0x8f35
00008E00  720E              jc 0x8e10
00008E02  C606641600        mov byte [0x1664],0x0
00008E07  E87201            call 0x8f7c
00008E0A  7305              jnc 0x8e11
00008E0C  FE066416          inc byte [0x1664]
00008E10  C3                ret
00008E11  803E651610        cmp byte [0x1665],0x10
00008E16  7508              jnz 0x8e20
00008E18  2AE4              sub ah,ah
00008E1A  CD1A              int 0x1a
00008E1C  89166E16          mov [0x166e],dx
00008E20  803E65160F        cmp byte [0x1665],0xf
00008E25  757F              jnz 0x8ea6
00008E27  2AE4              sub ah,ah
00008E29  CD1A              int 0x1a
00008E2B  2B166E16          sub dx,[0x166e]
00008E2F  3B166C16          cmp dx,[0x166c]
00008E33  7371              jnc 0x8ea6
00008E35  803E701600        cmp byte [0x1670],0x0
00008E3A  7469              jz 0x8ea5
00008E3C  803E731600        cmp byte [0x1673],0x0
00008E41  7562              jnz 0x8ea5
00008E43  803E180400        cmp byte [0x418],0x0
00008E48  755B              jnz 0x8ea5
00008E4A  FE0E7016          dec byte [0x1670]
00008E4E  C606781601        mov byte [0x1678],0x1
00008E53  A06816            mov al,[0x1668]
00008E56  A27316            mov [0x1673],al
00008E59  E8D113            call 0xa22d            ; Get a random number.
00008E5C  81E20F00          and dx,0xf
00008E60  03166616          add dx,[0x1666]
00008E64  89167116          mov [0x1671],dx
00008E68  B001              mov al,0x1
00008E6A  3B167905          cmp dx,[0x579]
00008E6E  7202              jc 0x8e72
00008E70  B0FF              mov al,0xff
00008E72  A27416            mov [0x1674],al
00008E75  E8B513            call 0xa22d            ; Get a random number.
00008E78  8ADA              mov bl,dl
00008E7A  81E30600          and bx,0x6
00008E7E  8B87C917          mov ax,[bx+0x17c9]
00008E82  A3DD17            mov [0x17dd],ax
00008E85  8B87D117          mov ax,[bx+0x17d1]
00008E89  A3DF17            mov [0x17df],ax
00008E8C  D0EB              shr bl,1
00008E8E  8A87D917          mov al,[bx+0x17d9]
00008E92  A27616            mov [0x1676],al
00008E95  C706EA172000      mov word [0x17ea],0x20
00008E9B  C606E91701        mov byte [0x17e9],0x1
00008EA0  C606751600        mov byte [0x1675],0x0
00008EA5  C3                ret

00008EA6  FE0E6516          dec byte [0x1665]
00008EAA  8B0E6616          mov cx,[0x1666]
00008EAE  8A166816          mov dl,[0x1668]
00008EB2  803E65160E        cmp byte [0x1665],0xe
00008EB7  760A              jna 0x8ec3
00008EB9  02166516          add dl,[0x1665]
00008EBD  80EA0E            sub dl,0xe
00008EC0  EB08              jmp short 0x8eca
00008EC2  90                nop
00008EC3  80C20E            add dl,0xe
00008EC6  2A166516          sub dl,[0x1665]
00008ECA  88166B16          mov [0x166b],dl
00008ECE  E80F12            call 0xa0e0
00008ED1  8BF8              mov di,ax
00008ED3  B800B8            mov ax,0xb800
00008ED6  8EC0              mov es,ax
00008ED8  FC                cld
00008ED9  B90400            mov cx,0x4
00008EDC  803E65160E        cmp byte [0x1665],0xe
00008EE1  7624              jna 0x8f07
00008EE3  803E180400        cmp byte [0x418],0x0
00008EE8  7418              jz 0x8f02
00008EEA  A06B16            mov al,[0x166b]
00008EED  2A066816          sub al,[0x1668]
00008EF1  2AE4              sub ah,ah
00008EF3  B103              mov cl,0x3
00008EF5  D3E0              shl ax,cl
00008EF7  05E015            add ax,0x15e0
00008EFA  8BF0              mov si,ax
00008EFC  B90400            mov cx,0x4
00008EFF  F3A5              rep movsw
00008F01  C3                ret
00008F02  2BC0              sub ax,ax
00008F04  F3AB              rep stosw
00008F06  C3                ret
00008F07  A06B16            mov al,[0x166b]
00008F0A  2A066816          sub al,[0x1668]
00008F0E  B40A              mov ah,0xa
00008F10  F6E4              mul ah
00008F12  058126            add ax,0x2681
00008F15  8BF0              mov si,ax
00008F17  F3A5              rep movsw
00008F19  C3                ret
00008F1A  2AFF              sub bh,bh
00008F1C  8ADA              mov bl,dl
00008F1E  80E303            and bl,0x3
00008F21  D0E3              shl bl,1
00008F23  8B8F5816          mov cx,[bx+0x1658]
00008F27  8ADA              mov bl,dl
00008F29  D0EB              shr bl,1
00008F2B  D0EB              shr bl,1
00008F2D  80E303            and bl,0x3
00008F30  8A976016          mov dl,[bx+0x1660]
00008F34  C3                ret
00008F35  A16616            mov ax,[0x1666]
00008F38  8A166816          mov dl,[0x1668]
00008F3C  8B1E7905          mov bx,[0x579]
00008F40  8A367B05          mov dh,[0x57b]
00008F44  BE2000            mov si,0x20
00008F47  BF1800            mov di,0x18
00008F4A  B90F0E            mov cx,0xe0f
00008F4D  E80913            call 0xa259
00008F50  7329              jnc 0x8f7b
00008F52  803E710501        cmp byte [0x571],0x1
00008F57  7521              jnz 0x8f7a
00008F59  803E5A0500        cmp byte [0x55a],0x0
00008F5E  751A              jnz 0x8f7a
00008F60  803E7B0560        cmp byte [0x57b],0x60
00008F65  7313              jnc 0x8f7a
00008F67  803E651605        cmp byte [0x1665],0x5
00008F6C  720C              jc 0x8f7a
00008F6E  803E651619        cmp byte [0x1665],0x19
00008F73  7305              jnc 0x8f7a
00008F75  C606510501        mov byte [0x551],0x1
00008F7A  F9                stc
00008F7B  C3                ret
00008F7C  A06916            mov al,[0x1669]
00008F7F  3C08              cmp al,0x8
00008F81  7325              jnc 0x8fa8
00008F83  BB0200            mov bx,0x2
00008F86  A804              test al,0x4
00008F88  7402              jz 0x8f8c
00008F8A  D0E3              shl bl,1
00008F8C  8B87301F          mov ax,[bx+0x1f30]
00008F90  051000            add ax,0x10
00008F93  3B066616          cmp ax,[0x1666]
00008F97  720F              jc 0x8fa8
00008F99  2D3000            sub ax,0x30
00008F9C  7302              jnc 0x8fa0
00008F9E  2BC0              sub ax,ax
00008FA0  3B066616          cmp ax,[0x1666]
00008FA4  7702              ja 0x8fa8
00008FA6  F9                stc
00008FA7  C3                ret
00008FA8  F8                clc
00008FA9  C3                ret
00008FAA  833E040000        cmp word [0x4],byte +0x0
00008FAF  7560              jnz 0x9011
00008FB1  8A167316          mov dl,[0x1673]
00008FB5  80FA00            cmp dl,0x0
00008FB8  7457              jz 0x9011
00008FBA  8B0EDF17          mov cx,[0x17df]
00008FBE  86CD              xchg cl,ch
00008FC0  BE1000            mov si,0x10
00008FC3  A17116            mov ax,[0x1671]
00008FC6  8B1E7905          mov bx,[0x579]
00008FCA  8A367B05          mov dh,[0x57b]
00008FCE  BF1800            mov di,0x18
00008FD1  B50E              mov ch,0xe
00008FD3  E88312            call 0xa259
00008FD6  733A              jnc 0x9012
00008FD8  E838F6            call 0x8613
00008FDB  E874FD            call 0x8d52
00008FDE  E82CF5            call 0x850d
00008FE1  803E751600        cmp byte [0x1675],0x0
00008FE6  7527              jnz 0x900f
00008FE8  C606751601        mov byte [0x1675],0x1
00008FED  E8A6F5            call 0x8596
00008FF0  B201              mov dl,0x1
00008FF2  803E7416FF        cmp byte [0x1674],0xff
00008FF7  7402              jz 0x8ffb
00008FF9  B2FF              mov dl,0xff
00008FFB  88167416          mov [0x1674],dl
00008FFF  C706EA176000      mov word [0x17ea],0x60
00009005  C606E91701        mov byte [0x17e9],0x1
0000900A  C6065C0500        mov byte [0x55c],0x0
0000900F  F9                stc
00009010  C3                ret
00009011  F8                clc
00009012  C3                ret

00009020  2BDB              sub bx,bx                  ; Black background.
00009022  B40B              mov ah,0xb                 ;
00009024  CD10              int 0x10                   ;
00009026  833E060007        cmp word [0x6],byte +0x7
0000902B  7515              jnz 0x9042
0000902D  803E530500        cmp byte [0x553],0x0
00009032  740E              jz 0x9042
00009034  E88436            call 0xc6bb
00009037  C70679059800      mov word [0x579],0x98
0000903D  C6067B055F        mov byte [0x57b],0x5f
00009042  B800B8            mov ax,0xb800
00009045  8EC0              mov es,ax
00009047  FC                cld
00009048  C70639180000      mov word [0x1839],0x0
0000904E  E84600            call 0x9097
00009051  E8FD3E            call 0xcf51		; Turn off the PC-Speaker.
00009054  E80A01            call 0x9161                 ; Select a palette.
00009057  833E040000        cmp word [0x4],byte +0x0
0000905C  751B              jnz 0x9079
0000905E  803E530500        cmp byte [0x553],0x0
00009063  7411              jz 0x9076
00009065  833E060007        cmp word [0x6],byte +0x7
0000906A  7505              jnz 0x9071
0000906C  E8D436            call 0xc743
0000906F  EB08              jmp short 0x9079
00009071  E86C1C            call 0xace0
00009074  EB03              jmp short 0x9079
00009076  E82D01            call 0x91a6
00009079  833E040007        cmp word [0x4],byte +0x7
0000907E  740A              jz 0x908a
00009080  B8AAAA            mov ax,0xaaaa
00009083  833E040002        cmp word [0x4],byte +0x2
00009088  7503              jnz 0x908d
0000908A  B85555            mov ax,0x5555
0000908D  A33918            mov [0x1839],ax
00009090  E80400            call 0x9097
00009093  E8BB3E            call 0xcf51		; Turn off the PC-Speaker.
00009096  C3                ret
00009097  E82C3C            call 0xccc6
0000909A  C70635180100      mov word [0x1835],0x1
000090A0  C606371808        mov byte [0x1837],0x8
000090A5  8B0E7905          mov cx,[0x579]
000090A9  8A167B05          mov dl,[0x57b]
000090AD  83C10C            add cx,byte +0xc
000090B0  81E1F0FF          and cx,0xfff0
000090B4  80C208            add dl,0x8
000090B7  C606381800        mov byte [0x1838],0x0
000090BC  E8083C            call 0xccc7
000090BF  890E3218          mov [0x1832],cx
000090C3  88163418          mov [0x1834],dl
000090C7  E81610            call 0xa0e0
000090CA  8BF8              mov di,ax
000090CC  8A1E3718          mov bl,[0x1837]
000090D0  A13918            mov ax,[0x1839]
000090D3  8B0E3518          mov cx,[0x1835]
000090D7  D1E9              shr cx,1
000090D9  D1E9              shr cx,1
000090DB  D1E9              shr cx,1
000090DD  F3AB              rep stosw
000090DF  8B0E3518          mov cx,[0x1835]
000090E3  D1E9              shr cx,1
000090E5  D1E9              shr cx,1
000090E7  81E1FE00          and cx,0xfe
000090EB  2BF9              sub di,cx
000090ED  81F70020          xor di,0x2000
000090F1  F7C70020          test di,0x2000
000090F5  7503              jnz 0x90fa
000090F7  83C750            add di,byte +0x50
000090FA  FECB              dec bl
000090FC  75D2              jnz 0x90d0
000090FE  803E38180F        cmp byte [0x1838],0xf
00009103  7501              jnz 0x9106
00009105  C3                ret
00009106  8306351820        add word [0x1835],byte +0x20
0000910B  8006371810        add byte [0x1837],0x10
00009110  8B0E3218          mov cx,[0x1832]
00009114  8A163418          mov dl,[0x1834]
00009118  83E910            sub cx,byte +0x10
0000911B  7307              jnc 0x9124
0000911D  2BC9              sub cx,cx
0000911F  800E381801        or byte [0x1838],0x1
00009124  A13518            mov ax,[0x1835]
00009127  03C1              add ax,cx
00009129  3D4001            cmp ax,0x140
0000912C  720D              jc 0x913b
0000912E  B84001            mov ax,0x140
00009131  2BC1              sub ax,cx
00009133  A33518            mov [0x1835],ax
00009136  800E381802        or byte [0x1838],0x2
0000913B  80EA08            sub dl,0x8
0000913E  7307              jnc 0x9147
00009140  2AD2              sub dl,dl
00009142  800E381804        or byte [0x1838],0x4
00009147  A03718            mov al,[0x1837]
0000914A  02C2              add al,dl
0000914C  7204              jc 0x9152
0000914E  3CC8              cmp al,0xc8
00009150  720C              jc 0x915e
00009152  B0C8              mov al,0xc8
00009154  2AC2              sub al,dl
00009156  A23718            mov [0x1837],al
00009159  800E381808        or byte [0x1838],0x8
0000915E  E95BFF            jmp 0x90bc

00009161  803E9706FD        cmp byte [0x697],0xfd	  ; Selects a palette if the machine is not a PCJr.
00009166  7410              jz 0x9178			  ;
00009168  B40B              mov ah,0xb          	  ;
0000916A  B701              mov bh,0x1          	  ;
0000916C  8B360400          mov si,[0x4]     		  ;
00009170  8A9C5318          mov bl,[si+0x1853]            ;
00009174  CD10              int 0x10                      ;
00009176  EB1F              jmp short 0x9197		  ;
00009178  8B360400          mov si,[0x4]                  ; Unimportant PCjr stuff.
0000917C  B301              mov bl,0x1		          ;
0000917E  8ABC3B18          mov bh,[si+0x183b]            ;
00009182  E81900            call 0x919e                   ; PCJr stuff.
00009185  B302              mov bl,0x2                    ;
00009187  8ABC4318          mov bh,[si+0x1843]            ;
0000918B  E81000            call 0x919e                   ; PCJr stuff.
0000918E  B303              mov bl,0x3                    ;
00009190  8ABC4B18          mov bh,[si+0x184b]            ;
00009194  E80700            call 0x919e                   ; PCJr stuff.
00009197  B40B              mov ah,0xb    		  ; Black background.
00009199  2BDB              sub bx,bx     		  ;
0000919B  CD10              int 0x10      		  ;
0000919D  C3                ret		

0000919E  B80010            mov ax,0x1000  		 ; Palette. PCJr only.
000091A1  56                push si        	 	 ;
000091A2  CD10              int 0x10      		 ;
000091A4  5E                pop si         		 ;
000091A5  C3                ret            		 ;

000091A6  833E060007        cmp word [0x6],byte +0x7
000091AB  7504              jnz 0x91b1
000091AD  E8C042            call 0xd470
000091B0  C3                ret

000091B1  E8513A            call 0xcc05
000091B4  B85B18            mov ax,0x185b
000091B7  803E520500        cmp byte [0x552],0x0
000091BC  7438              jz 0x91f6
000091BE  8B1E301C          mov bx,[0x1c30]
000091C2  8306301C02        add word [0x1c30],byte +0x2
000091C7  81E30600          and bx,0x6
000091CB  8B87261C          mov ax,[bx+0x1c26]
000091CF  803E801F00        cmp byte [0x1f80],0x0        ; Remove a life if any remain.
000091D4  7404              jz 0x91da                    ;
000091D6  FE0E801F          dec byte [0x1f80]            ;
000091DA  803E5205DD        cmp byte [0x552],0xdd
000091DF  7515              jnz 0x91f6
000091E1  833E080000        cmp word [0x8],byte +0x0
000091E6  740E              jz 0x91f6
000091E8  803E801F01        cmp byte [0x1f80],0x1        ; If less than one life remains jump to 0x91f6
000091ED  7207              jc 0x91f6                    ;
000091EF  E81E3E            call 0xd010
000091F2  E85C3D            call 0xcf51		; Turn off the PC-Speaker.
000091F5  C3                ret

000091F6  A32E1C            mov [0x1c2e],ax
000091F9  C7061B1C8080      mov word [0x1c1b],0x8080
000091FF  C6061D1C1C        mov byte [0x1c1d],0x1c
00009204  E84000            call 0x9247
00009207  2AE4              sub ah,ah
00009209  CD1A              int 0x1a
0000920B  89163018          mov [0x1830],dx
0000920F  E8023A            call 0xcc14
00009212  2AE4              sub ah,ah
00009214  CD1A              int 0x1a
00009216  3B163018          cmp dx,[0x1830]
0000921A  74F3              jz 0x920f
0000921C  803E1D1C14        cmp byte [0x1c1d],0x14
00009221  770F              ja 0x9232
00009223  2AFF              sub bh,bh
00009225  8A1E1D1C          mov bl,[0x1c1d]
00009229  80E306            and bl,0x6
0000922C  8B871E1C          mov ax,[bx+0x1c1e]
00009230  EB08              jmp short 0x923a
00009232  A11B1C            mov ax,[0x1c1b]
00009235  F9                stc
00009236  D0D8              rcr al,1
00009238  8AE0              mov ah,al
0000923A  A31B1C            mov [0x1c1b],ax
0000923D  FE0E1D1C          dec byte [0x1c1d]
00009241  75C1              jnz 0x9204
00009243  E80B3D            call 0xcf51		; Turn off the PC-Speaker.
00009246  C3                ret

00009247  FC                cld
00009248  1E                push ds
00009249  07                pop es
0000924A  8B362E1C          mov si,[0x1c2e]
0000924E  BF0E00            mov di,0xe
00009251  B96000            mov cx,0x60
00009254  AD                lodsw
00009255  23061B1C          and ax,[0x1c1b]
00009259  AB                stosw
0000925A  E2F8              loop 0x9254
0000925C  B800B8            mov ax,0xb800	; Draws the sprite.
0000925F  8EC0              mov es,ax		;
00009261  BE0E00            mov si,0xe		;
00009264  BFD00E            mov di,0xed0	;
00009267  B9080C            mov cx,0xc08	;
0000926A  E8600F            call 0xa1cd       	;
0000926D  C3                ret

00009270  C606BF1C00        mov byte [0x1cbf],0x0
00009275  C706E11C0000      mov word [0x1ce1],0x0
0000927B  C606C01C00        mov byte [0x1cc0],0x0
00009280  C606C11C00        mov byte [0x1cc1],0x0
00009285  C606B81C00        mov byte [0x1cb8],0x0
0000928A  C606C81CB1        mov byte [0x1cc8],0xb1
0000928F  E8EE35            call 0xc880
00009292  C3                ret

00009293  2AE4              sub ah,ah
00009295  CD1A              int 0x1a
00009297  8BCA              mov cx,dx
00009299  2B16C91C          sub dx,[0x1cc9]
0000929D  A1E11C            mov ax,[0x1ce1]
000092A0  250100            and ax,0x1
000092A3  050100            add ax,0x1
000092A6  3BD0              cmp dx,ax
000092A8  7301              jnc 0x92ab
000092AA  C3                ret

000092AB  E85AF5            call 0x8808   ; Get vertical retrace status.
000092AE  74FA              jz 0x92aa
000092B0  890EC91C          mov [0x1cc9],cx
000092B4  FF06E11C          inc word [0x1ce1]
000092B8  803EC11C00        cmp byte [0x1cc1],0x0
000092BD  7453              jz 0x9312
000092BF  FE0EC11C          dec byte [0x1cc1]
000092C3  7534              jnz 0x92f9
000092C5  E8893C            call 0xcf51		; Turn off the PC-Speaker.
000092C8  803EB81C00        cmp byte [0x1cb8],0x0
000092CD  7423              jz 0x92f2
000092CF  833E040000        cmp word [0x4],byte +0x0
000092D4  7411              jz 0x92e7
000092D6  C6065205DD        mov byte [0x552],0xdd
000092DB  C7067905A000      mov word [0x579],0xa0
000092E1  C6067B0560        mov byte [0x57b],0x60
000092E6  C3                ret

000092E7  803E801F00        cmp byte [0x1f80],0x0   ; Remove one life if any remain.
000092EC  7404              jz 0x92f2               ;
000092EE  FE0E801F          dec byte [0x1f80]       ;
000092F2  E81C02            call 0x9511
000092F5  E878FF            call 0x9270
000092F8  C3                ret

000092F9  E85601            call 0x9452
000092FC  B80401            mov ax,0x104
000092FF  2A06C11C          sub al,[0x1cc1]
00009303  803ED01CFF        cmp byte [0x1cd0],0xff
00009308  7402              jz 0x930c
0000930A  B4FF              mov ah,0xff
0000930C  E87A01            call 0x9489
0000930F  E91901            jmp 0x942b
00009312  803EB81C00        cmp byte [0x1cb8],0x0
00009317  7423              jz 0x933c
00009319  8A16B81C          mov dl,[0x1cb8]
0000931D  833EB91C00        cmp word [0x1cb9],byte +0x0
00009322  740E              jz 0x9332
00009324  FF0EB91C          dec word [0x1cb9]
00009328  E8020F            call 0xa22d            ; Get a random number.
0000932B  80E201            and dl,0x1
0000932E  7502              jnz 0x9332
00009330  B2FF              mov dl,0xff
00009332  8816D01C          mov [0x1cd0],dl
00009336  A1C61C            mov ax,[0x1cc6]
00009339  E99F00            jmp 0x93db
0000933C  803EBF1C00        cmp byte [0x1cbf],0x0
00009341  7562              jnz 0x93a5
00009343  803EC01C00        cmp byte [0x1cc0],0x0
00009348  753D              jnz 0x9387
0000934A  803E581D00        cmp byte [0x1d58],0x0
0000934F  751C              jnz 0x936d
00009351  803E7B05B4        cmp byte [0x57b],0xb4
00009356  7214              jc 0x936c
00009358  803E580500        cmp byte [0x558],0x0
0000935D  750D              jnz 0x936c
0000935F  E8CB0E            call 0xa22d            ; Get a random number.
00009362  8B1E0800          mov bx,[0x8]
00009366  3A97D11C          cmp dl,[bx+0x1cd1]
0000936A  7201              jc 0x936d
0000936C  C3                ret
0000936D  B001              mov al,0x1
0000936F  C706BA590000      mov word [0x59ba],0x0
00009375  813E7905A000      cmp word [0x579],0xa0
0000937B  7302              jnc 0x937f
0000937D  B0FF              mov al,0xff
0000937F  A2D01C            mov [0x1cd0],al
00009382  C606C01C04        mov byte [0x1cc0],0x4
00009387  FE0EC01C          dec byte [0x1cc0]
0000938B  7508              jnz 0x9395
0000938D  C606BF1C01        mov byte [0x1cbf],0x1
00009392  EB11              jmp short 0x93a5
00009394  90                nop
00009395  E8BA00            call 0x9452
00009398  A0C01C            mov al,[0x1cc0]
0000939B  8A26D01C          mov ah,[0x1cd0]
0000939F  E8E700            call 0x9489
000093A2  E98600            jmp 0x942b
000093A5  C606581D00        mov byte [0x1d58],0x0
000093AA  A1C61C            mov ax,[0x1cc6]
000093AD  803E7B05B4        cmp byte [0x57b],0xb4
000093B2  7227              jc 0x93db
000093B4  803E580500        cmp byte [0x558],0x0
000093B9  7520              jnz 0x93db
000093BB  E86F0E            call 0xa22d            ; Get a random number.
000093BE  8B1E0800          mov bx,[0x8]
000093C2  3A97D91C          cmp dl,[bx+0x1cd9]
000093C6  7713              ja 0x93db
000093C8  3B067905          cmp ax,[0x579]
000093CC  7708              ja 0x93d6
000093CE  C606D01C01        mov byte [0x1cd0],0x1
000093D3  EB06              jmp short 0x93db
000093D5  90                nop
000093D6  C606D01CFF        mov byte [0x1cd0],0xff
000093DB  803ED01C01        cmp byte [0x1cd0],0x1
000093E0  723D              jc 0x941f
000093E2  742E              jz 0x9412
000093E4  2D0800            sub ax,0x8
000093E7  7336              jnc 0x941f
000093E9  2BC0              sub ax,ax
000093EB  803EB81C00        cmp byte [0x1cb8],0x0
000093F0  740A              jz 0x93fc
000093F2  833EB91C00        cmp word [0x1cb9],byte +0x0
000093F7  7526              jnz 0x941f
000093F9  EB0F              jmp short 0x940a
000093FB  90                nop
000093FC  803E7B05B4        cmp byte [0x57b],0xb4
00009401  7207              jc 0x940a
00009403  803E580500        cmp byte [0x558],0x0
00009408  7415              jz 0x941f
0000940A  C606C11C04        mov byte [0x1cc1],0x4
0000940F  EB0E              jmp short 0x941f
00009411  90                nop
00009412  050800            add ax,0x8
00009415  3D1E01            cmp ax,0x11e
00009418  7205              jc 0x941f
0000941A  B81E01            mov ax,0x11e
0000941D  EBCC              jmp short 0x93eb
0000941F  A3C61C            mov [0x1cc6],ax
00009422  E82D00            call 0x9452
00009425  C706C41C040F      mov word [0x1cc4],0xf04
0000942B  8B0EC61C          mov cx,[0x1cc6]
0000942F  8A16C81C          mov dl,[0x1cc8]
00009433  E8AA0C            call 0xa0e0
00009436  A3CD1C            mov [0x1ccd],ax
00009439  803EC01C03        cmp byte [0x1cc0],0x3
0000943E  7403              jz 0x9443
00009440  E8CE00            call 0x9511
00009443  E8DF00            call 0x9525
00009446  7209              jc 0x9451
00009448  A1CD1C            mov ax,[0x1ccd]
0000944B  A3BD1C            mov [0x1cbd],ax
0000944E  E87A00            call 0x94cb
00009451  C3                ret
00009452  2AFF              sub bh,bh
00009454  803EB81C00        cmp byte [0x1cb8],0x0
00009459  7410              jz 0x946b
0000945B  FE06CF1C          inc byte [0x1ccf]
0000945F  8A1ECF1C          mov bl,[0x1ccf]
00009463  80E306            and bl,0x6
00009466  80CB08            or bl,0x8
00009469  7516              jnz 0x9481
0000946B  8006CF1C02        add byte [0x1ccf],0x2
00009470  8A1ECF1C          mov bl,[0x1ccf]
00009474  80E302            and bl,0x2
00009477  803ED01C01        cmp byte [0x1cd0],0x1
0000947C  7503              jnz 0x9481
0000947E  80CB04            or bl,0x4
00009481  8B87C815          mov ax,[bx+0x15c8]
00009485  A3BB1C            mov [0x1cbb],ax
00009488  C3                ret
00009489  B9040F            mov cx,0xf04
0000948C  2AC8              sub cl,al
0000948E  890EC41C          mov [0x1cc4],cx
00009492  80FCFF            cmp ah,0xff
00009495  7411              jz 0x94a8
00009497  2AE4              sub ah,ah
00009499  D0E0              shl al,1
0000949B  0106BB1C          add [0x1cbb],ax
0000949F  C706C61C0000      mov word [0x1cc6],0x0
000094A5  EB0F              jmp short 0x94b6
000094A7  90                nop
000094A8  2AE4              sub ah,ah
000094AA  D0E0              shl al,1
000094AC  D0E0              shl al,1
000094AE  D0E0              shl al,1
000094B0  052001            add ax,0x120
000094B3  A3C61C            mov [0x1cc6],ax
000094B6  1E                push ds
000094B7  07                pop es
000094B8  8B36BB1C          mov si,[0x1cbb]
000094BC  BF0E00            mov di,0xe
000094BF  B004              mov al,0x4
000094C1  E8DC0C            call 0xa1a0
000094C4  C706BB1C0E00      mov word [0x1cbb],0xe
000094CA  C3                ret
000094CB  8B0EC41C          mov cx,[0x1cc4]
000094CF  890EC21C          mov [0x1cc2],cx
000094D3  B800B8            mov ax,0xb800
000094D6  803EB81C00        cmp byte [0x1cb8],0x0
000094DB  7511              jnz 0x94ee
000094DD  8EC0              mov es,ax
000094DF  8B3EBD1C          mov di,[0x1cbd]
000094E3  8B36BB1C          mov si,[0x1cbb]
000094E7  BD401C            mov bp,0x1c40
000094EA  E80F0C            call 0xa0fc
000094ED  C3                ret

000094EE  1E                push ds
000094EF  8ED8              mov ds,ax
000094F1  07                pop es
000094F2  06                push es
000094F3  1E                push ds
000094F4  268B36BD1C        mov si,[es:0x1cbd]
000094F9  BF401C            mov di,0x1c40
000094FC  E8FB0C            call 0xa1fa
000094FF  07                pop es		; Draws the sprite.
00009500  1F                pop ds		;
00009501  8B36BB1C          mov si,[0x1cbb]	;
00009505  8B3EBD1C          mov di,[0x1cbd]	;
00009509  8B0EC41C          mov cx,[0x1cc4]	;
0000950D  E8BD0C            call 0xa1cd		;
00009510  C3                ret

00009511  B800B8            mov ax,0xb800       ; Draws the sprite.
00009514  8EC0              mov es,ax		;
00009516  8B3EBD1C          mov di,[0x1cbd]	;
0000951A  BE401C            mov si,0x1c40	;
0000951D  8B0EC21C          mov cx,[0x1cc2]	;
00009521  E8A90C            call 0xa1cd		;
00009524  C3                ret

00009525  803EB81C00        cmp byte [0x1cb8],0x0
0000952A  7538              jnz 0x9564
0000952C  A0BF1C            mov al,[0x1cbf]
0000952F  0A06C01C          or al,[0x1cc0]
00009533  0A06C11C          or al,[0x1cc1]
00009537  742B              jz 0x9564
00009539  803E7B05A3        cmp byte [0x57b],0xa3
0000953E  7224              jc 0x9564
00009540  803E580500        cmp byte [0x558],0x0
00009545  751D              jnz 0x9564
00009547  A1C61C            mov ax,[0x1cc6]
0000954A  052000            add ax,0x20
0000954D  3B067905          cmp ax,[0x579]
00009551  7211              jc 0x9564
00009553  2D3800            sub ax,0x38
00009556  7302              jnc 0x955a
00009558  2BC0              sub ax,ax
0000955A  3B067905          cmp ax,[0x579]
0000955E  7704              ja 0x9564
00009560  E80300            call 0x9566
00009563  C3                ret
00009564  F8                clc
00009565  C3                ret
00009566  833E040006        cmp word [0x4],byte +0x6
0000956B  750C              jnz 0x9579
0000956D  A07B05            mov al,[0x57b]
00009570  A2C81C            mov [0x1cc8],al
00009573  A17905            mov ax,[0x579]
00009576  A3C61C            mov [0x1cc6],ax
00009579  A1C61C            mov ax,[0x1cc6]
0000957C  03067905          add ax,[0x579]
00009580  D1E8              shr ax,1
00009582  3D1801            cmp ax,0x118
00009585  7203              jc 0x958a
00009587  B81701            mov ax,0x117
0000958A  A3C61C            mov [0x1cc6],ax
0000958D  B301              mov bl,0x1
0000958F  3DA000            cmp ax,0xa0
00009592  770A              ja 0x959e
00009594  B3FF              mov bl,0xff
00009596  BAA100            mov dx,0xa1
00009599  2BD0              sub dx,ax
0000959B  EB06              jmp short 0x95a3
0000959D  90                nop
0000959E  2D9F00            sub ax,0x9f
000095A1  8BD0              mov dx,ax
000095A3  881EB81C          mov [0x1cb8],bl
000095A7  C606BF1C01        mov byte [0x1cbf],0x1
000095AC  C606C11C00        mov byte [0x1cc1],0x0
000095B1  B103              mov cl,0x3
000095B3  D3EA              shr dx,cl
000095B5  8916B91C          mov [0x1cb9],dx
000095B9  833E040006        cmp word [0x4],byte +0x6
000095BE  752D              jnz 0x95ed
000095C0  E850F0            call 0x8613
000095C3  A0B81C            mov al,[0x1cb8]
000095C6  50                push ax
000095C7  C606B81C00        mov byte [0x1cb8],0x0
000095CC  C706C41C040F      mov word [0x1cc4],0xf04
000095D2  A1C815            mov ax,[0x15c8]
000095D5  A3BB1C            mov [0x1cbb],ax
000095D8  8B0EC61C          mov cx,[0x1cc6]
000095DC  8A16C81C          mov dl,[0x1cc8]
000095E0  E8FD0A            call 0xa0e0
000095E3  A3BD1C            mov [0x1cbd],ax
000095E6  E8E2FE            call 0x94cb
000095E9  58                pop ax
000095EA  A2B81C            mov [0x1cb8],al
000095ED  E821FF            call 0x9511
000095F0  E820F0            call 0x8613
000095F3  B80000            mov ax,0x0
000095F6  813E7905A000      cmp word [0x579],0xa0
000095FC  7303              jnc 0x9601
000095FE  B82201            mov ax,0x122
00009601  A37905            mov [0x579],ax
00009604  833E040000        cmp word [0x4],byte +0x0
00009609  7503              jnz 0x960e
0000960B  E82FE5            call 0x7b3d
0000960E  F9                stc
0000960F  C3                ret
00009610  A0BF1C            mov al,[0x1cbf]
00009613  0A06C01C          or al,[0x1cc0]
00009617  0A06C11C          or al,[0x1cc1]
0000961B  741C              jz 0x9639
0000961D  A17D32            mov ax,[0x327d]
00009620  8A167F32          mov dl,[0x327f]
00009624  BE1000            mov si,0x10
00009627  8B1EC61C          mov bx,[0x1cc6]
0000962B  8A36C81C          mov dh,[0x1cc8]
0000962F  BF2000            mov di,0x20
00009632  B91E0F            mov cx,0xf1e
00009635  E8210C            call 0xa259
00009638  C3                ret
00009639  F8                clc
0000963A  C3                ret
0000963B  0000              add [bx+si],al
0000963D  0000              add [bx+si],al
0000963F  00C6              add dh,al
00009641  06                push es
00009642  59                pop cx
00009643  1D00C3            sbb ax,0xc300
00009646  2AE4              sub ah,ah
00009648  CD1A              int 0x1a
0000964A  3B165A1D          cmp dx,[0x1d5a]
0000964E  7501              jnz 0x9651
00009650  C3                ret

00009651  8BCA              mov cx,dx
00009653  E8B2F1            call 0x8808   ; Get vertical retrace status.
00009656  74F8              jz 0x9650
00009658  890E5A1D          mov [0x1d5a],cx
0000965C  E8C800            call 0x9727
0000965F  72EF              jc 0x9650
00009661  803E591D00        cmp byte [0x1d59],0x0
00009666  7535              jnz 0x969d
00009668  803E7B0586        cmp byte [0x57b],0x86
0000966D  740F              jz 0x967e
0000966F  803E7B058E        cmp byte [0x57b],0x8e
00009674  7408              jz 0x967e
00009676  E8B40B            call 0xa22d            ; Get a random number.
00009679  80FA05            cmp dl,0x5
0000967C  77D2              ja 0x9650
0000967E  E87FF3            call 0x8a00
00009681  80C203            add dl,0x3
00009684  88165E1D          mov [0x1d5e],dl
00009688  E8A20B            call 0xa22d            ; Get a random number.
0000968B  81E20700          and dx,0x7
0000968F  03CA              add cx,dx
00009691  83C106            add cx,byte +0x6
00009694  890E5C1D          mov [0x1d5c],cx
00009698  C606591D1B        mov byte [0x1d59],0x1b
0000969D  FE0E591D          dec byte [0x1d59]
000096A1  8B0E5C1D          mov cx,[0x1d5c]
000096A5  8A165E1D          mov dl,[0x1d5e]
000096A9  803E591D0D        cmp byte [0x1d59],0xd
000096AE  7611              jna 0x96c1
000096B0  0216591D          add dl,[0x1d59]
000096B4  80EA0F            sub dl,0xf
000096B7  BB021B            mov bx,0x1b02
000096BA  2A3E591D          sub bh,[0x1d59]
000096BE  EB0F              jmp short 0x96cf
000096C0  90                nop
000096C1  80C20C            add dl,0xc
000096C4  2A16591D          sub dl,[0x1d59]
000096C8  BB0200            mov bx,0x2
000096CB  023E591D          add bh,[0x1d59]
000096CF  891E641D          mov [0x1d64],bx
000096D3  88165F1D          mov [0x1d5f],dl
000096D7  E8060A            call 0xa0e0
000096DA  A3621D            mov [0x1d62],ax
000096DD  E82C00            call 0x970c
000096E0  E84400            call 0x9727
000096E3  7207              jc 0x96ec
000096E5  803E591D00        cmp byte [0x1d59],0x0
000096EA  7501              jnz 0x96ed
000096EC  C3                ret
000096ED  B800B8            mov ax,0xb800
000096F0  8EC0              mov es,ax
000096F2  8B3E621D          mov di,[0x1d62]
000096F6  BEF01C            mov si,0x1cf0
000096F9  893E601D          mov [0x1d60],di
000096FD  8B0E641D          mov cx,[0x1d64]
00009701  890E661D          mov [0x1d66],cx
00009705  BD241D            mov bp,0x1d24
00009708  E8F109            call 0xa0fc
0000970B  C3                ret

0000970C  803E591D1A        cmp byte [0x1d59],0x1a
00009711  7413              jz 0x9726
00009713  B800B8            mov ax,0xb800		; Draws the sprite.
00009716  8EC0              mov es,ax			;
00009718  8B3E601D          mov di,[0x1d60]		;
0000971C  BE241D            mov si,0x1d24		;
0000971F  8B0E661D          mov cx,[0x1d66]		;
00009723  E8A70A            call 0xa1cd			;
00009726  C3                ret

00009727  803E591D00        cmp byte [0x1d59],0x0
0000972C  7502              jnz 0x9730
0000972E  F8                clc
0000972F  C3                ret
00009730  8B0E641D          mov cx,[0x1d64]
00009734  86E9              xchg ch,cl
00009736  A15C1D            mov ax,[0x1d5c]
00009739  8A165F1D          mov dl,[0x1d5f]
0000973D  BE1000            mov si,0x10
00009740  8B1E7905          mov bx,[0x579]
00009744  8A367B05          mov dh,[0x57b]
00009748  BF1800            mov di,0x18
0000974B  B50E              mov ch,0xe
0000974D  E8090B            call 0xa259
00009750  7305              jnc 0x9757
00009752  C606581D01        mov byte [0x1d58],0x1
00009757  C3                ret

00009760  C7066C1F0000      mov word [0x1f6c],0x0
00009766  2BC0              sub ax,ax
00009768  B201              mov dl,0x1
0000976A  813E7905A000      cmp word [0x579],0xa0
00009770  7705              ja 0x9777
00009772  B82C01            mov ax,0x12c
00009775  B2FF              mov dl,0xff
00009777  A3301F            mov [0x1f30],ax
0000977A  A3321F            mov [0x1f32],ax
0000977D  A3341F            mov [0x1f34],ax
00009780  88163C1F          mov [0x1f3c],dl
00009784  88163D1F          mov [0x1f3d],dl
00009788  88163E1F          mov [0x1f3e],dl
0000978C  C606481F01        mov byte [0x1f48],0x1
00009791  C606491F01        mov byte [0x1f49],0x1
00009796  C6064A1F01        mov byte [0x1f4a],0x1
0000979B  C606501F00        mov byte [0x1f50],0x0
000097A0  C606511F00        mov byte [0x1f51],0x0
000097A5  C606521F00        mov byte [0x1f52],0x0
000097AA  C3                ret

000097AB  2AE4              sub ah,ah
000097AD  CD1A              int 0x1a
000097AF  3B16651F          cmp dx,[0x1f65]
000097B3  7501              jnz 0x97b6
000097B5  C3                ret

000097B6  8916651F          mov [0x1f65],dx
000097BA  803E5A0500        cmp byte [0x55a],0x0
000097BF  75F4              jnz 0x97b5
000097C1  8B1E6C1F          mov bx,[0x1f6c]
000097C5  43                inc bx
000097C6  83FB03            cmp bx,byte +0x3
000097C9  7203              jc 0x97ce
000097CB  BB0000            mov bx,0x0
000097CE  891E6C1F          mov [0x1f6c],bx
000097D2  E8B902            call 0x9a8e
000097D5  72DE              jc 0x97b5
000097D7  E8BD01            call 0x9997
000097DA  72D9              jc 0x97b5
000097DC  8B1E6C1F          mov bx,[0x1f6c]
000097E0  80BF501F00        cmp byte [bx+0x1f50],0x0
000097E5  7434              jz 0x981b
000097E7  2AE4              sub ah,ah
000097E9  CD1A              int 0x1a
000097EB  8B1E6C1F          mov bx,[0x1f6c]
000097EF  D0E3              shl bl,1
000097F1  2B97531F          sub dx,[bx+0x1f53]
000097F5  83FA36            cmp dx,byte +0x36
000097F8  72BB              jc 0x97b5
000097FA  B201              mov dl,0x1
000097FC  B80000            mov ax,0x0
000097FF  813E7905A000      cmp word [0x579],0xa0
00009805  7705              ja 0x980c
00009807  B82C01            mov ax,0x12c
0000980A  B2FF              mov dl,0xff
0000980C  8987301F          mov [bx+0x1f30],ax
00009810  D0EB              shr bl,1
00009812  C687501F00        mov byte [bx+0x1f50],0x0
00009817  88973C1F          mov [bx+0x1f3c],dl
0000981B  8A973C1F          mov dl,[bx+0x1f3c]
0000981F  88973F1F          mov [bx+0x1f3f],dl
00009823  803E641600        cmp byte [0x1664],0x0
00009828  7409              jz 0x9833
0000982A  C706691F0C00      mov word [0x1f69],0xc
00009830  EB16              jmp short 0x9848
00009832  90                nop
00009833  B80800            mov ax,0x8
00009836  803E7B0560        cmp byte [0x57b],0x60
0000983B  7602              jna 0x983f
0000983D  D0E8              shr al,1
0000983F  A3691F            mov [0x1f69],ax
00009842  3B1E2F05          cmp bx,[0x52f]
00009846  750D              jnz 0x9855
00009848  80BF3C1F00        cmp byte [bx+0x1f3c],0x0
0000984D  7506              jnz 0x9855
0000984F  E8DB09            call 0xa22d            ; Get a random number.
00009852  EB66              jmp short 0x98ba
00009854  90                nop
00009855  803E5C0500        cmp byte [0x55c],0x0
0000985A  743A              jz 0x9896
0000985C  8A87361F          mov al,[bx+0x1f36]
00009860  3A067B05          cmp al,[0x57b]
00009864  7730              ja 0x9896
00009866  0410              add al,0x10
00009868  3A067B05          cmp al,[0x57b]
0000986C  7228              jc 0x9896
0000986E  E8BC09            call 0xa22d            ; Get a random number.
00009871  8B360800          mov si,[0x8]
00009875  3A946E1F          cmp dl,[si+0x1f6e]
00009879  771B              ja 0x9896
0000987B  C706691F0C00      mov word [0x1f69],0xc
00009881  B001              mov al,0x1
00009883  D0E3              shl bl,1
00009885  8B8F301F          mov cx,[bx+0x1f30]
00009889  D0EB              shr bl,1
0000988B  3B0E7905          cmp cx,[0x579]
0000988F  7202              jc 0x9893
00009891  B0FF              mov al,0xff
00009893  EB2D              jmp short 0x98c2
00009895  90                nop
00009896  B118              mov cl,0x18
00009898  803E7B0560        cmp byte [0x57b],0x60
0000989D  760B              jna 0x98aa
0000989F  B128              mov cl,0x28
000098A1  80BF3C1F00        cmp byte [bx+0x1f3c],0x0
000098A6  7502              jnz 0x98aa
000098A8  B110              mov cl,0x10
000098AA  E88009            call 0xa22d            ; Get a random number.
000098AD  3AD1              cmp dl,cl
000098AF  7715              ja 0x98c6
000098B1  B000              mov al,0x0
000098B3  80BF3C1F00        cmp byte [bx+0x1f3c],0x0
000098B8  7508              jnz 0x98c2
000098BA  8AC2              mov al,dl
000098BC  2401              and al,0x1
000098BE  7502              jnz 0x98c2
000098C0  B0FF              mov al,0xff
000098C2  88873C1F          mov [bx+0x1f3c],al
000098C6  8A973C1F          mov dl,[bx+0x1f3c]
000098CA  D0E3              shl bl,1
000098CC  8B87301F          mov ax,[bx+0x1f30]
000098D0  80FA01            cmp dl,0x1
000098D3  721D              jc 0x98f2
000098D5  7511              jnz 0x98e8
000098D7  0306691F          add ax,[0x1f69]
000098DB  3D2F01            cmp ax,0x12f
000098DE  7212              jc 0x98f2
000098E0  B82E01            mov ax,0x12e
000098E3  B2FF              mov dl,0xff
000098E5  EB0B              jmp short 0x98f2
000098E7  90                nop
000098E8  2B06691F          sub ax,[0x1f69]
000098EC  7304              jnc 0x98f2
000098EE  2BC0              sub ax,ax
000098F0  B201              mov dl,0x1
000098F2  8987301F          mov [bx+0x1f30],ax
000098F6  D0EB              shr bl,1
000098F8  88973C1F          mov [bx+0x1f3c],dl
000098FC  8A97361F          mov dl,[bx+0x1f36]
00009900  8BC8              mov cx,ax
00009902  E8DB07            call 0xa0e0
00009905  A34B1F            mov [0x1f4b],ax
00009908  8B1E6C1F          mov bx,[0x1f6c]
0000990C  80BF481F00        cmp byte [bx+0x1f48],0x0
00009911  750D              jnz 0x9920
00009913  8A873C1F          mov al,[bx+0x1f3c]
00009917  0A873F1F          or al,[bx+0x1f3f]
0000991B  7403              jz 0x9920
0000991D  E85D00            call 0x997d
00009920  E86B01            call 0x9a8e
00009923  7205              jc 0x992a
00009925  E86F00            call 0x9997
00009928  7301              jnc 0x992b
0000992A  C3                ret
0000992B  8B1E6C1F          mov bx,[0x1f6c]
0000992F  C687481F00        mov byte [bx+0x1f48],0x0
00009934  80BF3C1F00        cmp byte [bx+0x1f3c],0x0
00009939  750D              jnz 0x9948
0000993B  80BF3F1F00        cmp byte [bx+0x1f3f],0x0
00009940  743A              jz 0x997c
00009942  BE301E            mov si,0x1e30
00009945  EB1C              jmp short 0x9963
00009947  90                nop
00009948  BE501E            mov si,0x1e50
0000994B  FE874D1F          inc byte [bx+0x1f4d]
0000994F  F6874D1F01        test byte [bx+0x1f4d],0x1
00009954  7503              jnz 0x9959
00009956  83C620            add si,byte +0x20
00009959  80BF3C1F01        cmp byte [bx+0x1f3c],0x1
0000995E  7403              jz 0x9963
00009960  83C640            add si,byte +0x40
00009963  D0E3              shl bl,1
00009965  8B3E4B1F          mov di,[0x1f4b]
00009969  89BF421F          mov [bx+0x1f42],di
0000996D  B800B8            mov ax,0xb800
00009970  8EC0              mov es,ax
00009972  8BAF591F          mov bp,[bx+0x1f59]
00009976  B90208            mov cx,0x802
00009979  E8E907            call 0xa165
0000997C  C3                ret

0000997D  8B1E6C1F          mov bx,[0x1f6c]		; Draws the sprite.
00009981  D0E3              shl bl,1			;
00009983  B800B8            mov ax,0xb800		;
00009986  8EC0              mov es,ax			;
00009988  8BBF421F          mov di,[bx+0x1f42]		;
0000998C  8BB7591F          mov si,[bx+0x1f59]		;
00009990  B90208            mov cx,0x802		;
00009993  E83708            call 0xa1cd                 ;
00009996  C3                ret

00009997  8B1E6C1F          mov bx,[0x1f6c]
0000999B  8A97361F          mov dl,[bx+0x1f36]
0000999F  D0E3              shl bl,1
000099A1  8B87301F          mov ax,[bx+0x1f30]
000099A5  BE1000            mov si,0x10
000099A8  8B1E7905          mov bx,[0x579]
000099AC  8A367B05          mov dh,[0x57b]
000099B0  BF1800            mov di,0x18
000099B3  B9080E            mov cx,0xe08
000099B6  E8A008            call 0xa259
000099B9  7203              jc 0x99be
000099BB  E9CF00            jmp 0x9a8d
000099BE  8B1E6C1F          mov bx,[0x1f6c]
000099C2  80BF501F00        cmp byte [bx+0x1f50],0x0
000099C7  7573              jnz 0x9a3c
000099C9  803E7C0526        cmp byte [0x57c],0x26
000099CE  726C              jc 0x9a3c
000099D0  803E5C0500        cmp byte [0x55c],0x0
000099D5  7467              jz 0x9a3e
000099D7  C6065C0500        mov byte [0x55c],0x0
000099DC  C6065B0511        mov byte [0x55b],0x11
000099E1  C606710501        mov byte [0x571],0x1
000099E6  C6066E0500        mov byte [0x56e],0x0
000099EB  8B1E6C1F          mov bx,[0x1f6c]
000099EF  D0E3              shl bl,1
000099F1  8BBF421F          mov di,[bx+0x1f42]
000099F5  83BF301F10        cmp word [bx+0x1f30],byte +0x10
000099FA  7203              jc 0x99ff
000099FC  83EF04            sub di,byte +0x4
000099FF  893E671F          mov [0x1f67],di
00009A03  B800B8            mov ax,0xb800
00009A06  8EC0              mov es,ax
00009A08  BE701D            mov si,0x1d70
00009A0B  BD0E00            mov bp,0xe
00009A0E  B90608            mov cx,0x806
00009A11  E8E806            call 0xa0fc
00009A14  2AE4              sub ah,ah
00009A16  CD1A              int 0x1a
00009A18  8916651F          mov [0x1f65],dx
00009A1C  E8A134            call 0xcec0
00009A1F  2AE4              sub ah,ah
00009A21  CD1A              int 0x1a
00009A23  2B16651F          sub dx,[0x1f65]
00009A27  83FA08            cmp dx,byte +0x8
00009A2A  72F0              jc 0x9a1c
00009A2C  E82235            call 0xcf51		; Turn off the PC-Speaker.
00009A2F  8B3E671F          mov di,[0x1f67]	; Draws the sprite.
00009A33  BE0E00            mov si,0xe		;
00009A36  B90608            mov cx,0x806	;
00009A39  E89107            call 0xa1cd         ;
00009A3C  F9                stc
00009A3D  C3                ret

00009A3E  2AE4              sub ah,ah
00009A40  CD1A              int 0x1a
00009A42  8B1E6C1F          mov bx,[0x1f6c]
00009A46  C687501F01        mov byte [bx+0x1f50],0x1
00009A4B  C6873C1F01        mov byte [bx+0x1f3c],0x1
00009A50  D0E3              shl bl,1
00009A52  8997531F          mov [bx+0x1f53],dx
00009A56  E8BAEB            call 0x8613
00009A59  8B1E6C1F          mov bx,[0x1f6c]
00009A5D  D0E3              shl bl,1
00009A5F  8BB75F1F          mov si,[bx+0x1f5f]
00009A63  8BBF421F          mov di,[bx+0x1f42]
00009A67  B800B8            mov ax,0xb800
00009A6A  8EC0              mov es,ax
00009A6C  BD0E00            mov bp,0xe
00009A6F  B90208            mov cx,0x802
00009A72  E88706            call 0xa0fc
00009A75  E8DCEA            call 0x8554
00009A78  8B1E6C1F          mov bx,[0x1f6c]
00009A7C  8A87391F          mov al,[bx+0x1f39]
00009A80  E8B300            call 0x9b36
00009A83  B8E803            mov ax,0x3e8
00009A86  BBEE02            mov bx,0x2ee
00009A89  E8DF32            call 0xcd6b
00009A8C  F9                stc
00009A8D  C3                ret

00009A8E  803E731600        cmp byte [0x1673],0x0
00009A93  7502              jnz 0x9a97
00009A95  F8                clc
00009A96  C3                ret

00009A97  8B1E6C1F          mov bx,[0x1f6c]
00009A9B  8A97361F          mov dl,[bx+0x1f36]
00009A9F  D0E3              shl bl,1
00009AA1  8B87301F          mov ax,[bx+0x1f30]
00009AA5  BE1000            mov si,0x10
00009AA8  8BFE              mov di,si
00009AAA  8B1E7116          mov bx,[0x1671]
00009AAE  8A367316          mov dh,[0x1673]
00009AB2  B9080C            mov cx,0xc08
00009AB5  E8A107            call 0xa259
00009AB8  C3                ret

; Perform some form of check on the previously written seven bytes.
00009AC0  1E                push ds
00009AC1  07                pop es
00009AC2  B90700            mov cx,0x7
00009AC5  BE821F            mov si,0x1f82
00009AC8  AC                lodsb
00009AC9  BB0700            mov bx,0x7
00009ACC  2BD9              sub bx,cx
00009ACE  3A87891F          cmp al,[bx+0x1f89]
00009AD2  E1F4              loope 0x9ac8
00009AD4  7701              ja 0x9ad7
00009AD6  C3                ret

; Copy the seven bytes from one location to another.
00009AD7  BE821F            mov si,0x1f82
00009ADA  BF891F            mov di,0x1f89
00009ADD  B90700            mov cx,0x7
00009AE0  F3A4              rep movsb
00009AE2  C3                ret

00009AE3  A0801F            mov al,[0x1f80]
00009AE6  3A06811F          cmp al,[0x1f81]
00009AEA  7501              jnz 0x9aed
00009AEC  C3                ret

00009AED  A2811F            mov [0x1f81],al	; Draws the sprite.
00009AF0  2AE4              sub ah,ah		;
00009AF2  B104              mov cl,0x4		;
00009AF4  D3E0              shl ax,cl		;
00009AF6  052027            add ax,0x2720	;
00009AF9  8BF0              mov si,ax		;
00009AFB  B800B8            mov ax,0xb800	;
00009AFE  8EC0              mov es,ax		;
00009B00  BF6012            mov di,0x1260	;
00009B03  B90108            mov cx,0x801	;
00009B06  E8C406            call 0xa1cd         ;
00009B09  C3                ret

00009B0A  BF821F            mov di,0x1f82	; Write seven null bytes.
00009B0D  E80800            call 0x9b18         ;
00009B10  C3                ret

00009B11  BF891F            mov di,0x1f89	; Write seven null bytes.
00009B14  E80100            call 0x9b18         ;
00009B17  C3                ret

; Write seven null bytes to [ES:DI].
00009B18  1E                push ds
00009B19  07                pop es
00009B1A  B90700            mov cx,0x7
00009B1D  2AC0              sub al,al
00009B1F  F3AA              rep stosb
00009B21  C3                ret

00009B22  BB891F            mov bx,0x1f89
00009B25  BFCA12            mov di,0x12ca
00009B28  E83E00            call 0x9b69
00009B2B  C3                ret
00009B2C  BB821F            mov bx,0x1f82
00009B2F  BF3C14            mov di,0x143c
00009B32  E83400            call 0x9b69
00009B35  C3                ret

00009B36  B90600            mov cx,0x6
00009B39  8BD9              mov bx,cx
00009B3B  B400              mov ah,0x0
00009B3D  0287811F          add al,[bx+0x1f81]
00009B41  37                aaa
00009B42  8887811F          mov [bx+0x1f81],al
00009B46  8AC4              mov al,ah
00009B48  E2EF              loop 0x9b39
00009B4A  E8DFFF            call 0x9b2c
00009B4D  C3                ret

00009B4E  51                push cx
00009B4F  50                push ax
00009B50  53                push bx
00009B51  F8                clc
00009B52  9C                pushf
00009B53  B90700            mov cx,0x7
00009B56  9D                popf
00009B57  8BD9              mov bx,cx
00009B59  4B                dec bx
00009B5A  8A01              mov al,[bx+di]
00009B5C  1200              adc al,[bx+si]
00009B5E  37                aaa
00009B5F  8801              mov [bx+di],al
00009B61  9C                pushf
00009B62  E2F2              loop 0x9b56
00009B64  9D                popf
00009B65  5B                pop bx
00009B66  58                pop ax
00009B67  59                pop cx
00009B68  C3                ret

00009B69  B800B8            mov ax,0xb800		; Draws the sprite.
00009B6C  8EC0              mov es,ax			;
00009B6E  893E901F          mov [0x1f90],di		;
00009B72  891E931F          mov [0x1f93],bx		;
00009B76  C606921F00        mov byte [0x1f92],0x0	;
00009B7B  8B1E931F          mov bx,[0x1f93]		;
00009B7F  8A07              mov al,[bx]			;
00009B81  2AE4              sub ah,ah			;
00009B83  B104              mov cl,0x4			;
00009B85  D3E0              shl ax,cl			;
00009B87  052027            add ax,0x2720		;
00009B8A  8BF0              mov si,ax			;
00009B8C  8B3E901F          mov di,[0x1f90]		;
00009B90  B90108            mov cx,0x801		;
00009B93  E83706            call 0xa1cd                 ;
00009B96  8306901F02        add word [0x1f90],byte +0x2
00009B9B  FF06931F          inc word [0x1f93]
00009B9F  FE06921F          inc byte [0x1f92]
00009BA3  803E921F07        cmp byte [0x1f92],0x7
00009BA8  740E              jz 0x9bb8
00009BAA  803E921F03        cmp byte [0x1f92],0x3
00009BAF  75CA              jnz 0x9b7b
00009BB1  8306901F02        add word [0x1f90],byte +0x2
00009BB6  EBC3              jmp short 0x9b7b
00009BB8  C3                ret
00009BB9  0000              add [bx+si],al
00009BBB  0000              add [bx+si],al
00009BBD  0000              add [bx+si],al
00009BBF  00B800B8          add [bx+si-0x4800],bh
00009BC3  8EC0              mov es,ax
00009BC5  833E040002        cmp word [0x4],byte +0x2
00009BCA  7552              jnz 0x9c1e
00009BCC  FC                cld
00009BCD  2BFF              sub di,di
00009BCF  B8AAAA            mov ax,0xaaaa
00009BD2  B95000            mov cx,0x50
00009BD5  F3AB              rep stosw
00009BD7  BF0020            mov di,0x2000
00009BDA  B95000            mov cx,0x50
00009BDD  F3AB              rep stosw
00009BDF  C70654260000      mov word [0x2654],0x0
00009BE5  E84506            call 0xa22d            ; Get a random number.
00009BE8  81E21800          and dx,0x18
00009BEC  3A165326          cmp dl,[0x2653]
00009BF0  74F3              jz 0x9be5
00009BF2  88165326          mov [0x2653],dl    	; Draws the sprite.
00009BF6  8B1E5426          mov bx,[0x2654]	;
00009BFA  88975626          mov [bx+0x2656],dl	;
00009BFE  81C22020          add dx,0x2020	;
00009C02  8BF2              mov si,dx		;
00009C04  8BFB              mov di,bx		;
00009C06  D1E7              shl di,1		;
00009C08  81C7A000          add di,0xa0		;
00009C0C  B90104            mov cx,0x401	;
00009C0F  E8BB05            call 0xa1cd		;
00009C12  FF065426          inc word [0x2654]
00009C16  833E542628        cmp word [0x2654],byte +0x28
00009C1B  72C8              jc 0x9be5
00009C1D  C3                ret

00009C1E  833E040007        cmp word [0x4],byte +0x7
00009C23  7504              jnz 0x9c29
00009C25  E81708            call 0xa43f
00009C28  C3                ret
00009C29  833E040006        cmp word [0x4],byte +0x6
00009C2E  753E              jnz 0x9c6e
00009C30  2BC0              sub ax,ax
00009C32  E89B01            call 0x9dd0
00009C35  BB7025            mov bx,0x2570
00009C38  B84A06            mov ax,0x64a
00009C3B  E81603            call 0x9f54 ; Call interleaved scanline renderer.
00009C3E  C70650264800      mov word [0x2650],0x48
00009C44  C606522638        mov byte [0x2652],0x38
00009C49  B8D20D            mov ax,0xdd2
00009C4C  E83901            call 0x9d88
00009C4F  B8F60D            mov ax,0xdf6
00009C52  E84B01            call 0x9da0
00009C55  BEA01F            mov si,0x1fa0	; Draws the portrait sprite.
00009C58  BF7E06            mov di,0x67e	;
00009C5B  B90210            mov cx,0x1002	;
00009C5E  E86C05            call 0xa1cd		;
00009C61  BB4423            mov bx,0x2344
00009C64  B8840B            mov ax,0xb84
00009C67  E8EA02            call 0x9f54		; Call interleaved scanline renderer.
00009C6A  E80A23            call 0xbf77
00009C6D  C3                ret

00009C6E  833E040005        cmp word [0x4],byte +0x5
00009C73  7548              jnz 0x9cbd
00009C75  B84006            mov ax,0x640
00009C78  E85501            call 0x9dd0
00009C7B  BB7025            mov bx,0x2570
00009C7E  B8B60C            mov ax,0xcb6
00009C81  E8D002            call 0x9f54		 ; Call interleaved scanline renderer.
00009C84  C7065026F800      mov word [0x2650],0xf8
00009C8A  C606522660        mov byte [0x2652],0x60
00009C8F  B80E14            mov ax,0x140e
00009C92  E8F300            call 0x9d88
00009C95  B83414            mov ax,0x1434
00009C98  E80501            call 0x9da0
00009C9B  B83E14            mov ax,0x143e
00009C9E  E8FF00            call 0x9da0
00009CA1  B8A016            mov ax,0x16a0
00009CA4  E81101            call 0x9db8
00009CA7  BB4423            mov bx,0x2344
00009CAA  B88411            mov ax,0x1184
00009CAD  E8A402            call 0x9f54 	; Call interleaved scanline renderer.
00009CB0  BEE01F            mov si,0x1fe0       ; Draws the sprite.
00009CB3  BFD60D            mov di,0xdd6	;
00009CB6  B90210            mov cx,0x1002	;
00009CB9  E81105            call 0xa1cd         ;
00009CBC  C3                ret

00009CBD  833E040004        cmp word [0x4],byte +0x4
00009CC2  752A              jnz 0x9cee
00009CC4  B84006            mov ax,0x640
00009CC7  E80601            call 0x9dd0
00009CCA  BB7025            mov bx,0x2570
00009CCD  B8BA0C            mov ax,0xcba
00009CD0  E88102            call 0x9f54 ; Call interleaved scanline renderer.
00009CD3  C70650260801      mov word [0x2650],0x108
00009CD9  C606522660        mov byte [0x2652],0x60
00009CDE  B83914            mov ax,0x1439
00009CE1  E8A400            call 0x9d88
00009CE4  B8C016            mov ax,0x16c0
00009CE7  E88B00            call 0x9d75
00009CEA  E8E116            call 0xb3ce
00009CED  C3                ret
00009CEE  833E040003        cmp word [0x4],byte +0x3
00009CF3  7544              jnz 0x9d39
00009CF5  B84006            mov ax,0x640
00009CF8  E8D500            call 0x9dd0
00009CFB  BB7025            mov bx,0x2570
00009CFE  B8900C            mov ax,0xc90
00009D01  E85002            call 0x9f54 ; Call interleaved scanline renderer.
00009D04  C70650266000      mov word [0x2650],0x60
00009D0A  C606522660        mov byte [0x2652],0x60
00009D0F  B80C14            mov ax,0x140c
00009D12  E87300            call 0x9d88
00009D15  B81814            mov ax,0x1418
00009D18  E88500            call 0x9da0
00009D1B  BB4423            mov bx,0x2344
00009D1E  B88411            mov ax,0x1184
00009D21  E83002            call 0x9f54 ; Call interleaved scanline renderer.
00009D24  BB4423            mov bx,0x2344
00009D27  B8A211            mov ax,0x11a2
00009D2A  E82702            call 0x9f54 ; Call interleaved scanline renderer.
00009D2D  BB2426            mov bx,0x2624
00009D30  2BC0              sub ax,ax
00009D32  E81F02            call 0x9f54 ; Call interleaved scanline renderer.
00009D35  E8D312            call 0xb00b
00009D38  C3                ret
00009D39  B84006            mov ax,0x640
00009D3C  E89100            call 0x9dd0
00009D3F  BB7025            mov bx,0x2570
00009D42  B8A00C            mov ax,0xca0
00009D45  E80C02            call 0x9f54 ; Call interleaved scanline renderer.
00009D48  C7065026A000      mov word [0x2650],0xa0
00009D4E  C606522660        mov byte [0x2652],0x60
00009D53  B80614            mov ax,0x1406
00009D56  E82F00            call 0x9d88
00009D59  BB4423            mov bx,0x2344
00009D5C  B8C411            mov ax,0x11c4
00009D5F  E8F201            call 0x9f54 ; Call interleaved scanline renderer.
00009D62  B82214            mov ax,0x1422
00009D65  E83800            call 0x9da0
00009D68  B89016            mov ax,0x1690
00009D6B  E84A00            call 0x9db8
00009D6E  B8B616            mov ax,0x16b6
00009D71  E80100            call 0x9d75
00009D74  C3                ret
00009D75  A33426            mov [0x2634],ax
00009D78  BB8423            mov bx,0x2384
00009D7B  E8D601            call 0x9f54 ; Call interleaved scanline renderer.
00009D7E  A13426            mov ax,[0x2634]
00009D81  BB8C23            mov bx,0x238c
00009D84  E8CD01            call 0x9f54 ; Call interleaved scanline renderer.
00009D87  C3                ret
00009D88  A33426            mov [0x2634],ax
00009D8B  BE0800            mov si,0x8
00009D8E  A13426            mov ax,[0x2634]
00009D91  8B9C3426          mov bx,[si+0x2634]
00009D95  56                push si
00009D96  E8BB01            call 0x9f54 ; Call interleaved scanline renderer.
00009D99  5E                pop si
00009D9A  83EE02            sub si,byte +0x2
00009D9D  75EF              jnz 0x9d8e
00009D9F  C3                ret
00009DA0  A33426            mov [0x2634],ax
00009DA3  BE0A00            mov si,0xa
00009DA6  A13426            mov ax,[0x2634]
00009DA9  8B9C3C26          mov bx,[si+0x263c]
00009DAD  56                push si
00009DAE  E8A301            call 0x9f54 ; Call interleaved scanline renderer.
00009DB1  5E                pop si
00009DB2  83EE02            sub si,byte +0x2
00009DB5  75EF              jnz 0x9da6
00009DB7  C3                ret
00009DB8  A33426            mov [0x2634],ax
00009DBB  BE0800            mov si,0x8
00009DBE  A13426            mov ax,[0x2634]
00009DC1  8B9C4626          mov bx,[si+0x2646]
00009DC5  56                push si
00009DC6  E88B01            call 0x9f54 ; Call interleaved scanline renderer.
00009DC9  5E                pop si
00009DCA  83EE02            sub si,byte +0x2
00009DCD  75EF              jnz 0x9dbe
00009DCF  C3                ret
00009DD0  A37E26            mov [0x267e],ax
00009DD3  BB1C25            mov bx,0x251c
00009DD6  E87B01            call 0x9f54 ; Call interleaved scanline renderer.
00009DD9  2BC0              sub ax,ax
00009DDB  FC                cld
00009DDC  8B3E7E26          mov di,[0x267e]
00009DE0  81C78402          add di,0x284
00009DE4  B92400            mov cx,0x24
00009DE7  F3AB              rep stosw
00009DE9  8B3E7E26          mov di,[0x267e]
00009DED  81C78411          add di,0x1184
00009DF1  B92400            mov cx,0x24
00009DF4  F3AB              rep stosw
00009DF6  8B3E7E26          mov di,[0x267e]
00009DFA  81C78422          add di,0x2284
00009DFE  B02A              mov al,0x2a
00009E00  E80E00            call 0x9e11
00009E03  8B3E7E26          mov di,[0x267e]
00009E07  81C7CB22          add di,0x22cb
00009E0B  B0A8              mov al,0xa8
00009E0D  E80100            call 0x9e11
00009E10  C3                ret
00009E11  B95F00            mov cx,0x5f
00009E14  268805            mov [es:di],al
00009E17  81F70020          xor di,0x2000
00009E1B  F7C70020          test di,0x2000
00009E1F  7503              jnz 0x9e24
00009E21  83C750            add di,byte +0x50
00009E24  E2EE              loop 0x9e14
00009E26  C3                ret

00009E30  B800B8            mov ax,0xb800	; Draw the title screen's purple background.
00009E33  8EC0              mov es,ax		;
00009E35  FC                cld			;
00009E36  2BFF              sub di,di		;
00009E38  B8AAAA            mov ax,0xaaaa	;
00009E3B  B9A00F            mov cx,0xfa0	;
00009E3E  F3AB              rep stosw		;
00009E40  BF0020            mov di,0x2000	;
00009E43  B9A00F            mov cx,0xfa0	;
00009E46  F3AB              rep stosw		;
00009E48  E88301            call 0x9fce         ; Draw the fence.
00009E4B  BBA028            mov bx,0x28a0	; Select a sprite.
00009E4E  2BC0              sub ax,ax		;
00009E50  E80101            call 0x9f54         ; Call interleaved scanline renderer.
00009E53  E84200            call 0x9e98		; Draw something onto the fence.
00009E56  E85B02            call 0xa0b4		; Draw stuff #2.
00009E59  E85F01            call 0x9fbb         ; Interleaved scanline renderer helper function #3.
00009E5C  E85100            call 0x9eb0		; Call a procedure that draws the title screen's background and fence as well.
00009E5F  C3                ret

00009E60  B800B8            mov ax,0xb800	; Draw the title screen's purple background.
00009E63  8EC0              mov es,ax		;
00009E65  FC                cld			;
00009E66  2BFF              sub di,di		;
00009E68  B8AAAA            mov ax,0xaaaa	;
00009E6B  B9A00F            mov cx,0xfa0	;
00009E6E  F3AB              rep stosw		;
00009E70  BF0020            mov di,0x2000	;
00009E73  B9A00F            mov cx,0xfa0	;
00009E76  F3AB              rep stosw		;
00009E78  E85301            call 0x9fce 	; Draw the fence.
00009E7B  BBA028            mov bx,0x28a0	; Select a sprite.
00009E7E  2BC0              sub ax,ax		;
00009E80  E8D100            call 0x9f54         ; Call interleaved scanline renderer.
00009E83  E81200            call 0x9e98		; Draw something onto the fence.
00009E86  A10800            mov ax,[0x8]
00009E89  50                push ax
00009E8A  C70608000100      mov word [0x8],0x1
00009E90  E82102            call 0xa0b4		; Draw stuff #2.
00009E93  58                pop ax
00009E94  A30800            mov [0x8],ax
00009E97  C3                ret

; Draw something onto the fence.
00009E98  8B1EF86D          mov bx,[0x6df8]             ; Draws the sprite.
00009E9C  81E30300          and bx,0x3			;
00009EA0  D0E3              shl bl,1			;
00009EA2  8BB7D12A          mov si,[bx+0x2ad1]		;
00009EA6  BF0219            mov di,0x1902		;
00009EA9  B90108            mov cx,0x801		;
00009EAC  E81E03            call 0xa1cd			;
00009EAF  C3                ret

00009EB0  BB0F00            mov bx,0xf
00009EB3  C687151000        mov byte [bx+0x1015],0x0
00009EB8  4B                dec bx
00009EB9  75F8              jnz 0x9eb3
00009EBB  BF4001            mov di,0x140
00009EBE  B780              mov bh,0x80
00009EC0  C706CA2A0000      mov word [0x2aca],0x0
00009EC6  E82D00            call 0x9ef6
00009EC9  BF4006            mov di,0x640
00009ECC  B730              mov bh,0x30
00009ECE  C706CA2A0500      mov word [0x2aca],0x5
00009ED4  E81F00            call 0x9ef6
00009ED7  BF400B            mov di,0xb40
00009EDA  B700              mov bh,0x0
00009EDC  C706CA2A0A00      mov word [0x2aca],0xa
00009EE2  E81100            call 0x9ef6
00009EE5  C606250510        mov byte [0x525],0x10
00009EEA  C7062F050000      mov word [0x52f],0x0
00009EF0  C606310501        mov byte [0x531],0x1
00009EF5  C3                ret

00009EF6  883EC92A          mov [0x2ac9],bh
00009EFA  C606C42A00        mov byte [0x2ac4],0x0
00009EFF  57                push di
00009F00  06                push es
00009F01  8B1E0800          mov bx,[0x8]
00009F05  8A9FBA2A          mov bl,[bx+0x2aba]
00009F09  8A3EC92A          mov bh,[0x2ac9]
00009F0D  B81000            mov ax,0x10
00009F10  8EC0              mov es,ax
00009F12  BFD704            mov di,0x4d7
00009F15  E895DB            call 0x7aad
00009F18  07                pop es	        ; Draws the sprite.
00009F19  5F                pop di		;
00009F1A  57                push di		;
00009F1B  BED704            mov si,0x4d7	;
00009F1E  B90210            mov cx,0x1002	;
00009F21  E8A902            call 0xa1cd		;
00009F24  2AFF              sub bh,bh
00009F26  8A1EC42A          mov bl,[0x2ac4]
00009F2A  8ACB              mov cl,bl
00009F2C  D0EB              shr bl,1
00009F2E  D0EB              shr bl,1
00009F30  F6D1              not cl
00009F32  80E103            and cl,0x3
00009F35  D0E1              shl cl,1
00009F37  A04005            mov al,[0x540]
00009F3A  D2E0              shl al,cl
00009F3C  8B36CA2A          mov si,[0x2aca]
00009F40  08801610          or [bx+si+0x1016],al
00009F44  5F                pop di
00009F45  83C704            add di,byte +0x4
00009F48  FE06C42A          inc byte [0x2ac4]
00009F4C  803EC42A14        cmp byte [0x2ac4],0x14
00009F51  72AC              jc 0x9eff
00009F53  C3                ret

; Interleaved scanline renderer.
00009F54  8B0F              mov cx,[bx]
00009F56  890EC72A          mov [0x2ac7],cx
00009F5A  A3CC2A            mov [0x2acc],ax
00009F5D  83C302            add bx,byte +0x2
00009F60  8B37              mov si,[bx]
00009F62  81FEFFFF          cmp si,0xffff
00009F66  7501              jnz 0x9f69
00009F68  C3                ret

; Interleaved scanline renderer helper function #1.
00009F69  8B7F02            mov di,[bx+0x2]
00009F6C  033ECC2A          add di,[0x2acc]
00009F70  FC                cld
00009F71  882ED02A          mov [0x2ad0],ch
00009F75  2AED              sub ch,ch
00009F77  890ECE2A          mov [0x2ace],cx
00009F7B  8B0ECE2A          mov cx,[0x2ace]
00009F7F  F3A4              rep movsb
00009F81  2B3ECE2A          sub di,[0x2ace]
00009F85  81F70020          xor di,0x2000
00009F89  F7C70020          test di,0x2000
00009F8D  7503              jnz 0x9f92
00009F8F  83C750            add di,byte +0x50
00009F92  FE0ED02A          dec byte [0x2ad0]
00009F96  75E3              jnz 0x9f7b
00009F98  83C304            add bx,byte +0x4
00009F9B  8B0EC72A          mov cx,[0x2ac7]
00009F9F  EBBF              jmp short 0x9f60

; Interleaved scanline renderer helper function #2.
00009FA1  C606C42A04        mov byte [0x2ac4],0x4	; Draws the sprite.
00009FA6  BE8026            mov si,0x2680		;
00009FA9  B90510            mov cx,0x1005		;
00009FAC  57                push di			;
00009FAD  E81D02            call 0xa1cd                 ;
00009FB0  5F                pop di
00009FB1  83C714            add di,byte +0x14
00009FB4  FE0EC42A          dec byte [0x2ac4]
00009FB8  75EC              jnz 0x9fa6
00009FBA  C3                ret

; Interleaved scanline renderer helper function #3.
00009FBB  BFC503            mov di,0x3c5
00009FBE  E8E0FF            call 0x9fa1
00009FC1  BFC508            mov di,0x8c5
00009FC4  E8DAFF            call 0x9fa1
00009FC7  BFC50D            mov di,0xdc5
00009FCA  E8D4FF            call 0x9fa1
00009FCD  C3                ret

; Draws the fence.
00009FCE  C706C22A3E10      mov word [0x2ac2],0x103e
00009FD4  8306C22A02        add word [0x2ac2],byte +0x2
00009FD9  8B3EC22A          mov di,[0x2ac2]
00009FDD  81FF9010          cmp di,0x1090
00009FE1  731F              jnc 0xa002
00009FE3  E84702            call 0xa22d			; Get a random number.
00009FE6  81E23000          and dx,0x30
00009FEA  3A16C42A          cmp dl,[0x2ac4]
00009FEE  74F3              jz 0x9fe3
00009FF0  8816C42A          mov [0x2ac4],dl		; Draws the sprite.
00009FF4  81C20429          add dx,0x2904		;	
00009FF8  8BF2              mov si,dx			;
00009FFA  B90108            mov cx,0x801		;
00009FFD  E8CD01            call 0xa1cd        		;
0000A000  EBD2              jmp short 0x9fd4
0000A002  BF8011            mov di,0x1180
0000A005  B85556            mov ax,0x5655
0000A008  B90005            mov cx,0x500
0000A00B  FC                cld
0000A00C  F3AB              rep stosw
0000A00E  BF8031            mov di,0x3180
0000A011  B90005            mov cx,0x500
0000A014  F3AB              rep stosw
0000A016  C706C22A4429      mov word [0x2ac2],0x2944
0000A01C  C606C42A09        mov byte [0x2ac4],0x9
0000A021  E80902            call 0xa22d			; Get a random number.
0000A024  81E27607          and dx,0x776		; Draws the sprite.
0000A028  81C2C012          add dx,0x12c0		;
0000A02C  8BFA              mov di,dx			;
0000A02E  8B36C22A          mov si,[0x2ac2]		;
0000A032  B90105            mov cx,0x501		;
0000A035  E89501            call 0xa1cd                 ;
0000A038  FE0EC42A          dec byte [0x2ac4]
0000A03C  75E3              jnz 0xa021
0000A03E  8306C22A0A        add word [0x2ac2],byte +0xa
0000A043  813EC22A6C29      cmp word [0x2ac2],0x296c
0000A049  72D1              jc 0xa01c
0000A04B  C606C42A05        mov byte [0x2ac4],0x5
0000A050  E8DA01            call 0xa22d       		; Get a random number.
0000A053  81E23E00          and dx,0x3e			; Draws the sprite.
0000A057  81C2983A          add dx,0x3a98		;
0000A05B  8BFA              mov di,dx			;
0000A05D  BE6C29            mov si,0x296c		;	
0000A060  B90105            mov cx,0x501		;
0000A063  E86701            call 0xa1cd			;
0000A066  FE0EC42A          dec byte [0x2ac4]
0000A06A  75E4              jnz 0xa050
0000A06C  C3                ret

; Draw stuff #1.
0000A06D  893EC22A          mov [0x2ac2],di
0000A071  B003              mov al,0x3
0000A073  81FF2017          cmp di,0x1720
0000A077  7202              jc 0xa07b
0000A079  FEC8              dec al			; Draws the trash bin lid sprite.
0000A07B  A2C42A            mov [0x2ac4],al		;
0000A07E  8106C22AE001      add word [0x2ac2],0x1e0	;
0000A084  BE7629            mov si,0x2976		;
0000A087  B9050C            mov cx,0xc05		;
0000A08A  E84001            call 0xa1cd			;
0000A08D  8B3EC22A          mov di,[0x2ac2]		; Draws the trash bin side sprite.
0000A091  8106C22A4001      add word [0x2ac2],0x140	;
0000A097  BEEE29            mov si,0x29ee		;
0000A09A  B90408            mov cx,0x804		;
0000A09D  E82D01            call 0xa1cd			;
0000A0A0  FE0EC42A          dec byte [0x2ac4]		; Draws the trash bin bottom sprite.
0000A0A4  75E7              jnz 0xa08d			;
0000A0A6  8B3EC22A          mov di,[0x2ac2]		;
0000A0AA  BE2E2A            mov si,0x2a2e		;
0000A0AD  B9040B            mov cx,0xb04		;
0000A0B0  E81A01            call 0xa1cd			;
0000A0B3  C3                ret

; Draw stuff #2.
0000A0B4  8B1E0800          mov bx,[0x8]
0000A0B8  8A9FB22A          mov bl,[bx+0x2ab2]
0000A0BC  891EC52A          mov [0x2ac5],bx
0000A0C0  8BBF862A          mov di,[bx+0x2a86]
0000A0C4  83FF00            cmp di,byte +0x0
0000A0C7  7501              jnz 0xa0ca
0000A0C9  C3                ret

; Draw stuff #3.
0000A0CA  E8A0FF            call 0xa06d		; Call draw stuff #1.
0000A0CD  8B1EC52A          mov bx,[0x2ac5]
0000A0D1  83C302            add bx,byte +0x2
0000A0D4  EBE6              jmp short 0xa0bc
0000A0D6  C3                ret

0000A0E0  8AC2              mov al,dl
0000A0E2  B428              mov ah,0x28
0000A0E4  F6E4              mul ah
0000A0E6  F6C201            test dl,0x1
0000A0E9  7403              jz 0xa0ee
0000A0EB  05D81F            add ax,0x1fd8
0000A0EE  8BD1              mov dx,cx
0000A0F0  D1EA              shr dx,1
0000A0F2  D1EA              shr dx,1
0000A0F4  03C2              add ax,dx
0000A0F6  80E103            and cl,0x3
0000A0F9  D0E1              shl cl,1
0000A0FB  C3                ret

0000A0FC  FC                cld
0000A0FD  880EE02A          mov [0x2ae0],cl
0000A101  882EE22A          mov [0x2ae2],ch
0000A105  2AED              sub ch,ch
0000A107  BAF00F            mov dx,0xff0
0000A10A  8A0EE02A          mov cl,[0x2ae0]
0000A10E  BAC030            mov dx,0x30c0
0000A111  268B1D            mov bx,[es:di]
0000A114  3E895E00          mov [ds:bp+0x0],bx
0000A118  AD                lodsw
0000A119  A3E32A            mov [0x2ae3],ax
0000A11C  84E2              test dl,ah
0000A11E  7502              jnz 0xa122
0000A120  0AE2              or ah,dl
0000A122  84E6              test dh,ah
0000A124  7502              jnz 0xa128
0000A126  0AE6              or ah,dh
0000A128  84C2              test dl,al
0000A12A  7502              jnz 0xa12e
0000A12C  0AC2              or al,dl
0000A12E  84C6              test dh,al
0000A130  7502              jnz 0xa134
0000A132  0AC6              or al,dh
0000A134  81F2CC33          xor dx,0x33cc
0000A138  F6C603            test dh,0x3
0000A13B  75DF              jnz 0xa11c
0000A13D  23C3              and ax,bx
0000A13F  0B06E32A          or ax,[0x2ae3]
0000A143  AB                stosw
0000A144  83C502            add bp,byte +0x2
0000A147  E2C5              loop 0xa10e
0000A149  2B3EE02A          sub di,[0x2ae0]
0000A14D  2B3EE02A          sub di,[0x2ae0]
0000A151  81F70020          xor di,0x2000
0000A155  F7C70020          test di,0x2000
0000A159  7503              jnz 0xa15e
0000A15B  83C750            add di,byte +0x50
0000A15E  FE0EE22A          dec byte [0x2ae2]
0000A162  75A6              jnz 0xa10a
0000A164  C3                ret
0000A165  FC                cld
0000A166  880EE02A          mov [0x2ae0],cl
0000A16A  882EE22A          mov [0x2ae2],ch
0000A16E  2AED              sub ch,ch
0000A170  8A0EE02A          mov cl,[0x2ae0]
0000A174  268B1D            mov bx,[es:di]
0000A177  3E895E00          mov [ds:bp+0x0],bx
0000A17B  AD                lodsw
0000A17C  23C3              and ax,bx
0000A17E  AB                stosw
0000A17F  83C502            add bp,byte +0x2
0000A182  E2F0              loop 0xa174
0000A184  2B3EE02A          sub di,[0x2ae0]
0000A188  2B3EE02A          sub di,[0x2ae0]
0000A18C  81F70020          xor di,0x2000
0000A190  F7C70020          test di,0x2000
0000A194  7503              jnz 0xa199
0000A196  83C750            add di,byte +0x50
0000A199  FE0EE22A          dec byte [0x2ae2]
0000A19D  75D1              jnz 0xa170
0000A19F  C3                ret

0000A1A0  FC                cld
0000A1A1  8936E92A          mov [0x2ae9],si
0000A1A5  880EE02A          mov [0x2ae0],cl
0000A1A9  882EE22A          mov [0x2ae2],ch
0000A1AD  D0E0              shl al,1
0000A1AF  A2EB2A            mov [0x2aeb],al
0000A1B2  2AED              sub ch,ch
0000A1B4  8A0EE02A          mov cl,[0x2ae0]
0000A1B8  F3A5              rep movsw
0000A1BA  8A0EEB2A          mov cl,[0x2aeb]
0000A1BE  010EE92A          add [0x2ae9],cx
0000A1C2  8B36E92A          mov si,[0x2ae9]
0000A1C6  FE0EE22A          dec byte [0x2ae2]
0000A1CA  75E8              jnz 0xa1b4
0000A1CC  C3                ret

; Draws a sprite.
0000A1CD  FC                cld
0000A1CE  880EE02A          mov [0x2ae0],cl
0000A1D2  882EE22A          mov [0x2ae2],ch
0000A1D6  2AED              sub ch,ch
0000A1D8  8A0EE02A          mov cl,[0x2ae0]
0000A1DC  F3A5              rep movsw
0000A1DE  2B3EE02A          sub di,[0x2ae0]
0000A1E2  2B3EE02A          sub di,[0x2ae0]
0000A1E6  81F70020          xor di,0x2000
0000A1EA  F7C70020          test di,0x2000
0000A1EE  7503              jnz 0xa1f3
0000A1F0  83C750            add di,byte +0x50
0000A1F3  FE0EE22A          dec byte [0x2ae2]
0000A1F7  75DF              jnz 0xa1d8
0000A1F9  C3                ret

0000A1FA  FC                cld
0000A1FB  26880EE02A        mov [es:0x2ae0],cl
0000A200  26882EE22A        mov [es:0x2ae2],ch
0000A205  2AED              sub ch,ch
0000A207  268A0EE02A        mov cl,[es:0x2ae0]
0000A20C  F3A5              rep movsw
0000A20E  262B36E02A        sub si,[es:0x2ae0]
0000A213  262B36E02A        sub si,[es:0x2ae0]
0000A218  81F60020          xor si,0x2000
0000A21C  F7C60020          test si,0x2000
0000A220  7503              jnz 0xa225
0000A222  83C650            add si,byte +0x50
0000A225  26FE0EE22A        dec byte [es:0x2ae2]
0000A22A  75DB              jnz 0xa207
0000A22C  C3                ret

; Random number generator.
0000A22D  8B16E52A          mov dx,[0x2ae5]
0000A231  32D6              xor dl,dh
0000A233  D0EA              shr dl,1
0000A235  D0EA              shr dl,1
0000A237  D11EE52A          rcr word [0x2ae5],1
0000A23B  8B16E52A          mov dx,[0x2ae5]
0000A23F  C3                ret

; Get random number generator seed value based on time of day counter.
0000A240  B000              mov al,0x0		; Latch and read the time of day counter.
0000A242  E643              out 0x43,al		;
0000A244  90                nop			;
0000A245  90                nop			;
0000A246  E440              in al,0x40		;
0000A248  8AE0              mov ah,al		;
0000A24A  90                nop			;
0000A24B  E440              in al,0x40		;
0000A24D  3D0000            cmp ax,0x0		; Replace the counter value with 0xFA59 if zero.
0000A250  7503              jnz 0xa255          ;
0000A252  B859FA            mov ax,0xfa59       ;
0000A255  A3E52A            mov [0x2ae5],ax     ; [0x2AE5] = Counter value.
0000A258  C3                ret

0000A259  03C6              add ax,si
0000A25B  3BC3              cmp ax,bx
0000A25D  7220              jc 0xa27f
0000A25F  2BC6              sub ax,si
0000A261  2BC7              sub ax,di
0000A263  7302              jnc 0xa267
0000A265  2BC0              sub ax,ax
0000A267  3BC3              cmp ax,bx
0000A269  7714              ja 0xa27f
0000A26B  02D1              add dl,cl
0000A26D  3AD6              cmp dl,dh
0000A26F  720E              jc 0xa27f
0000A271  2AD1              sub dl,cl
0000A273  2AD5              sub dl,ch
0000A275  7302              jnc 0xa279
0000A277  2AD2              sub dl,dl
0000A279  3AD6              cmp dl,dh
0000A27B  7702              ja 0xa27f
0000A27D  F9                stc
0000A27E  C3                ret
0000A27F  F8                clc
0000A280  C3                ret
0000A281  0000              add [bx+si],al
0000A283  0000              add [bx+si],al
0000A285  0000              add [bx+si],al
0000A287  0000              add [bx+si],al
0000A289  0000              add [bx+si],al
0000A28B  0000              add [bx+si],al
0000A28D  0000              add [bx+si],al
0000A28F  00833E8D          add [bp+di-0x72c2],al
0000A293  2E087201          or [cs:bp+si+0x1],dh
0000A297  C3                ret
0000A298  803E9A0600        cmp byte [0x69a],0x0
0000A29D  75F8              jnz 0xa297
0000A29F  C706922EFFFF      mov word [0x2e92],0xffff
0000A2A5  C606912EFF        mov byte [0x2e91],0xff
0000A2AA  B90700            mov cx,0x7
0000A2AD  8BD9              mov bx,cx
0000A2AF  4B                dec bx
0000A2B0  A07B05            mov al,[0x57b]
0000A2B3  2A87D42B          sub al,[bx+0x2bd4]
0000A2B7  7302              jnc 0xa2bb
0000A2B9  F6D0              not al
0000A2BB  3A06912E          cmp al,[0x2e91]
0000A2BF  7707              ja 0xa2c8
0000A2C1  A2912E            mov [0x2e91],al
0000A2C4  891E922E          mov [0x2e92],bx
0000A2C8  E2E3              loop 0xa2ad
0000A2CA  813E922EFFFF      cmp word [0x2e92],0xffff
0000A2D0  7506              jnz 0xa2d8
0000A2D2  C706922E0000      mov word [0x2e92],0x0
0000A2D8  8B1E8D2E          mov bx,[0x2e8d]
0000A2DC  8B36922E          mov si,[0x2e92]
0000A2E0  8A84D42B          mov al,[si+0x2bd4]
0000A2E4  88876A2B          mov [bx+0x2b6a],al
0000A2E8  A2982E            mov [0x2e98],al
0000A2EB  A17905            mov ax,[0x579]
0000A2EE  D0E3              shl bl,1
0000A2F0  3D0801            cmp ax,0x108
0000A2F3  7203              jc 0xa2f8
0000A2F5  B80701            mov ax,0x107
0000A2F8  25FC0F            and ax,0xffc
0000A2FB  89875A2B          mov [bx+0x2b5a],ax
0000A2FF  A3962E            mov [0x2e96],ax
0000A302  B90800            mov cx,0x8
0000A305  8BD9              mov bx,cx
0000A307  4B                dec bx
0000A308  3B1E8D2E          cmp bx,[0x2e8d]
0000A30C  7429              jz 0xa337
0000A30E  80BF722B00        cmp byte [bx+0x2b72],0x0
0000A313  7422              jz 0xa337
0000A315  51                push cx
0000A316  8A976A2B          mov dl,[bx+0x2b6a]
0000A31A  D0E3              shl bl,1
0000A31C  8B875A2B          mov ax,[bx+0x2b5a]
0000A320  8B1E962E          mov bx,[0x2e96]
0000A324  8A36982E          mov dh,[0x2e98]
0000A328  BE1800            mov si,0x18
0000A32B  8BFE              mov di,si
0000A32D  B90F0F            mov cx,0xf0f
0000A330  E826FF            call 0xa259
0000A333  59                pop cx
0000A334  7301              jnc 0xa337
0000A336  C3                ret
0000A337  E2CC              loop 0xa305
0000A339  E8D7E2            call 0x8613
0000A33C  803EF27000        cmp byte [0x70f2],0x0
0000A341  7403              jz 0xa346
0000A343  E81533            call 0xd65b
0000A346  8B1E8D2E          mov bx,[0x2e8d]
0000A34A  891E942E          mov [0x2e94],bx
0000A34E  C687722B01        mov byte [bx+0x2b72],0x1
0000A353  8A976A2B          mov dl,[bx+0x2b6a]
0000A357  D0E3              shl bl,1
0000A359  8B8F5A2B          mov cx,[bx+0x2b5a]
0000A35D  E880FD            call 0xa0e0
0000A360  8BF8              mov di,ax			; Draws the gift sprite.
0000A362  BEF02A            mov si,0x2af0		;
0000A365  B800B8            mov ax,0xb800		;
0000A368  8EC0              mov es,ax			;
0000A36A  B9030F            mov cx,0xf03		;
0000A36D  E85DFE            call 0xa1cd			;
0000A370  C7068D2EFFFF      mov word [0x2e8d],0xffff
0000A376  2BDB              sub bx,bx      ; Black background.
0000A378  B40B              mov ah,0xb     ;
0000A37A  CD10              int 0x10       ;
0000A37C  E8EF1E            call 0xc26e
0000A37F  803EF27000        cmp byte [0x70f2],0x0
0000A384  7403              jz 0xa389
0000A386  E8A132            call 0xd62a
0000A389  E8E9E1            call 0x8575
0000A38C  B8E803            mov ax,0x3e8
0000A38F  BBA504            mov bx,0x4a5
0000A392  E8D629            call 0xcd6b
0000A395  C3                ret
0000A396  2AE4              sub ah,ah
0000A398  CD1A              int 0x1a
0000A39A  3B168F2E          cmp dx,[0x2e8f]
0000A39E  7501              jnz 0xa3a1
0000A3A0  C3                ret
0000A3A1  89168F2E          mov [0x2e8f],dx
0000A3A5  833E8D2E08        cmp word [0x2e8d],byte +0x8
0000A3AA  7230              jc 0xa3dc
0000A3AC  B90800            mov cx,0x8
0000A3AF  8BD9              mov bx,cx
0000A3B1  4B                dec bx
0000A3B2  80BF722B00        cmp byte [bx+0x2b72],0x0
0000A3B7  7421              jz 0xa3da
0000A3B9  51                push cx
0000A3BA  8A976A2B          mov dl,[bx+0x2b6a]
0000A3BE  D0E3              shl bl,1
0000A3C0  8B875A2B          mov ax,[bx+0x2b5a]
0000A3C4  BE1800            mov si,0x18
0000A3C7  8BFE              mov di,si
0000A3C9  8B1E7905          mov bx,[0x579]
0000A3CD  8A367B05          mov dh,[0x57b]
0000A3D1  B90F0E            mov cx,0xe0f
0000A3D4  E882FE            call 0xa259
0000A3D7  59                pop cx
0000A3D8  7209              jc 0xa3e3
0000A3DA  E2D3              loop 0xa3af
0000A3DC  C706942EFFFF      mov word [0x2e94],0xffff
0000A3E2  C3                ret
0000A3E3  8BD9              mov bx,cx
0000A3E5  4B                dec bx
0000A3E6  3B1E942E          cmp bx,[0x2e94]
0000A3EA  74F6              jz 0xa3e2
0000A3EC  53                push bx
0000A3ED  E823E2            call 0x8613
0000A3F0  803EF27000        cmp byte [0x70f2],0x0
0000A3F5  7403              jz 0xa3fa
0000A3F7  E86132            call 0xd65b
0000A3FA  5B                pop bx
0000A3FB  C687722B00        mov byte [bx+0x2b72],0x0
0000A400  8A976A2B          mov dl,[bx+0x2b6a]
0000A404  891E8D2E          mov [0x2e8d],bx
0000A408  D0E3              shl bl,1
0000A40A  8B8F5A2B          mov cx,[bx+0x2b5a]
0000A40E  E8CFFC            call 0xa0e0
0000A411  8BF8              mov di,ax			; Draws the sprite.
0000A413  BE7A2B            mov si,0x2b7a		;
0000A416  B800B8            mov ax,0xb800		;
0000A419  8EC0              mov es,ax			;
0000A41B  B9030F            mov cx,0xf03		;
0000A41E  E8ACFD            call 0xa1cd			;
0000A421  803EF27000        cmp byte [0x70f2],0x0
0000A426  7403              jz 0xa42b
0000A428  E8FF31            call 0xd62a
0000A42B  E847E1            call 0x8575
0000A42E  BB0100            mov bx,0x1   ; Select a palette.
0000A431  B40B              mov ah,0xb   ;
0000A433  CD10              int 0x10     ;
0000A435  B8E803            mov ax,0x3e8
0000A438  BB4903            mov bx,0x349
0000A43B  E82D29            call 0xcd6b
0000A43E  C3                ret
0000A43F  2BC0              sub ax,ax
0000A441  BB242E            mov bx,0x2e24
0000A444  E80DFB            call 0x9f54 ; Call interleaved scanline renderer.
0000A447  C6068A2EBF        mov byte [0x2e8a],0xbf
0000A44C  C7068B2E0000      mov word [0x2e8b],0x0
0000A452  C706882E2000      mov word [0x2e88],0x20
0000A458  2BDB              sub bx,bx
0000A45A  803E8A2EBF        cmp byte [0x2e8a],0xbf
0000A45F  7408              jz 0xa469
0000A461  E8C9FD            call 0xa22d            ; Get a random number.
0000A464  8ADA              mov bl,dl
0000A466  80E302            and bl,0x2
0000A469  8B0E882E          mov cx,[0x2e88]
0000A46D  8A168A2E          mov dl,[0x2e8a]
0000A471  53                push bx
0000A472  E89E00            call 0xa513
0000A475  5B                pop bx
0000A476  8B368B2E          mov si,[0x2e8b]
0000A47A  A1882E            mov ax,[0x2e88]
0000A47D  B104              mov cl,0x4
0000A47F  D3E8              shr ax,cl
0000A481  2D0200            sub ax,0x2
0000A484  7302              jnc 0xa488
0000A486  2BC0              sub ax,ax
0000A488  3D1200            cmp ax,0x12
0000A48B  7203              jc 0xa490
0000A48D  B81100            mov ax,0x11
0000A490  8A94DB2B          mov dl,[si+0x2bdb]
0000A494  2AF6              sub dh,dh
0000A496  03C2              add ax,dx
0000A498  8BF0              mov si,ax
0000A49A  889CE22B          mov [si+0x2be2],bl
0000A49E  8306882E10        add word [0x2e88],byte +0x10
0000A4A3  813E882E1101      cmp word [0x2e88],0x111
0000A4A9  72AD              jc 0xa458
0000A4AB  FF068B2E          inc word [0x2e8b]
0000A4AF  802E8A2E18        sub byte [0x2e8a],0x18
0000A4B4  803E8A2E2F        cmp byte [0x2e8a],0x2f
0000A4B9  7397              jnc 0xa452
0000A4BB  B8FFFF            mov ax,0xffff
0000A4BE  A38D2E            mov [0x2e8d],ax
0000A4C1  A3942E            mov [0x2e94],ax
0000A4C4  2BC0              sub ax,ax
0000A4C6  A3722B            mov [0x2b72],ax
0000A4C9  A3742B            mov [0x2b74],ax
0000A4CC  A3762B            mov [0x2b76],ax
0000A4CF  A3782B            mov [0x2b78],ax
0000A4D2  8B0E1404          mov cx,[0x414]
0000A4D6  83F900            cmp cx,byte +0x0
0000A4D9  7505              jnz 0xa4e0
0000A4DB  41                inc cx
0000A4DC  890E1404          mov [0x414],cx
0000A4E0  83F908            cmp cx,byte +0x8
0000A4E3  7603              jna 0xa4e8
0000A4E5  B90800            mov cx,0x8
0000A4E8  8BD9              mov bx,cx
0000A4EA  4B                dec bx
0000A4EB  C687722B01        mov byte [bx+0x2b72],0x1
0000A4F0  B2B0              mov dl,0xb0
0000A4F2  88976A2B          mov [bx+0x2b6a],dl
0000A4F6  51                push cx
0000A4F7  D0E3              shl bl,1
0000A4F9  8B8F4A2B          mov cx,[bx+0x2b4a]
0000A4FD  898F5A2B          mov [bx+0x2b5a],cx
0000A501  E8DCFB            call 0xa0e0
0000A504  8BF8              mov di,ax		; Draws the gift sprite.
0000A506  BEF02A            mov si,0x2af0	;
0000A509  B9030F            mov cx,0xf03	;
0000A50C  E8BEFC            call 0xa1cd		;
0000A50F  59                pop cx
0000A510  E2D6              loop 0xa4e8
0000A512  C3                ret
0000A513  53                push bx
0000A514  E8C9FB            call 0xa0e0
0000A517  8BF8              mov di,ax		; Draws the sprite.
0000A519  B800B8            mov ax,0xb800	;
0000A51C  8EC0              mov es,ax		;
0000A51E  5B                pop bx		;
0000A51F  8BB7202E          mov si,[bx+0x2e20]	;
0000A523  B90208            mov cx,0x802	;
0000A526  E8A4FC            call 0xa1cd         ;
0000A529  C3                ret
0000A52A  A07B05            mov al,[0x57b]
0000A52D  2C05              sub al,0x5
0000A52F  24F8              and al,0xf8
0000A531  B90700            mov cx,0x7
0000A534  8BD9              mov bx,cx
0000A536  4B                dec bx
0000A537  3A87D42B          cmp al,[bx+0x2bd4]
0000A53B  7404              jz 0xa541
0000A53D  E2F5              loop 0xa534
0000A53F  EB3C              jmp short 0xa57d
0000A541  8AE8              mov ch,al
0000A543  A17905            mov ax,[0x579]
0000A546  050700            add ax,0x7
0000A549  B104              mov cl,0x4
0000A54B  D3E8              shr ax,cl
0000A54D  2D0200            sub ax,0x2
0000A550  7302              jnc 0xa554
0000A552  2BC0              sub ax,ax
0000A554  3D1200            cmp ax,0x12
0000A557  7203              jc 0xa55c
0000A559  B81100            mov ax,0x11
0000A55C  8A97DB2B          mov dl,[bx+0x2bdb]
0000A560  2AF6              sub dh,dh
0000A562  03C2              add ax,dx
0000A564  8BF0              mov si,ax
0000A566  80BCE22B00        cmp byte [si+0x2be2],0x0
0000A56B  7510              jnz 0xa57d
0000A56D  80C505            add ch,0x5
0000A570  882E7B05          mov [0x57b],ch
0000A574  80C532            add ch,0x32
0000A577  882E7C05          mov [0x57c],ch
0000A57B  F9                stc
0000A57C  C3                ret
0000A57D  F8                clc
0000A57E  C3                ret
0000A57F  002A              add [bp+si],ch
0000A581  E4CD              in al,0xcd
0000A583  1A8B1E04          sbb cl,[bp+di+0x41e]
0000A587  00D0              add al,dl
0000A589  E38B              jcxz 0xa516
0000A58B  8F                db 0x8f
0000A58C  F2328BC22B        repne xor cl,[bp+di+0x2bc2]
0000A591  06                push es
0000A592  8C32              mov [bp+si],segr6
0000A594  3BC1              cmp ax,cx
0000A596  7301              jnc 0xa599
0000A598  C3                ret
0000A599  89168C32          mov [0x328c],dx
0000A59D  E84A02            call 0xa7ea
0000A5A0  72F6              jc 0xa598
0000A5A2  E86BF0            call 0x9610
0000A5A5  72F1              jc 0xa598
0000A5A7  FE06EA32          inc byte [0x32ea]
0000A5AB  E87FFC            call 0xa22d            ; Get a random number.
0000A5AE  A0EA32            mov al,[0x32ea]
0000A5B1  22C2              and al,dl
0000A5B3  3006EB32          xor [0x32eb],al
0000A5B7  A17D32            mov ax,[0x327d]
0000A5BA  2B067905          sub ax,[0x579]
0000A5BE  B2FF              mov dl,0xff
0000A5C0  7304              jnc 0xa5c6
0000A5C2  F7D0              not ax
0000A5C4  B201              mov dl,0x1
0000A5C6  8816ED32          mov [0x32ed],dl
0000A5CA  8A1E7F32          mov bl,[0x327f]
0000A5CE  80C314            add bl,0x14
0000A5D1  2A1E7B05          sub bl,[0x57b]
0000A5D5  B2FF              mov dl,0xff
0000A5D7  7304              jnc 0xa5dd
0000A5D9  F6D3              not bl
0000A5DB  B201              mov dl,0x1
0000A5DD  8816EE32          mov [0x32ee],dl
0000A5E1  D1E8              shr ax,1
0000A5E3  D1E8              shr ax,1
0000A5E5  D0EB              shr bl,1
0000A5E7  02C3              add al,bl
0000A5E9  A2EC32            mov [0x32ec],al
0000A5EC  8B1E8A32          mov bx,[0x328a]
0000A5F0  83FB27            cmp bx,byte +0x27
0000A5F3  7207              jc 0xa5fc
0000A5F5  BB2600            mov bx,0x26
0000A5F8  891E8A32          mov [0x328a],bx
0000A5FC  80BF8E3200        cmp byte [bx+0x328e],0x0
0000A601  7578              jnz 0xa67b
0000A603  FF0E8A32          dec word [0x328a]
0000A607  2AE4              sub ah,ah
0000A609  CD1A              int 0x1a
0000A60B  2B161004          sub dx,[0x410]
0000A60F  B103              mov cl,0x3
0000A611  D3EA              shr dx,cl
0000A613  A0EC32            mov al,[0x32ec]
0000A616  2AC2              sub al,dl
0000A618  7302              jnc 0xa61c
0000A61A  2AC0              sub al,al
0000A61C  3A06EB32          cmp al,[0x32eb]
0000A620  7220              jc 0xa642
0000A622  C606813201        mov byte [0x3281],0x1
0000A627  E803FC            call 0xa22d            ; Get a random number.
0000A62A  80FA00            cmp dl,0x0
0000A62D  740C              jz 0xa63b
0000A62F  80FA07            cmp dl,0x7
0000A632  770B              ja 0xa63f
0000A634  80E201            and dl,0x1
0000A637  7502              jnz 0xa63b
0000A639  B2FF              mov dl,0xff
0000A63B  88168032          mov [0x3280],dl
0000A63F  E99A00            jmp 0xa6dc
0000A642  A0EB32            mov al,[0x32eb]
0000A645  242F              and al,0x2f
0000A647  751F              jnz 0xa668
0000A649  E8E1FB            call 0xa22d            ; Get a random number.
0000A64C  80E201            and dl,0x1
0000A64F  7502              jnz 0xa653
0000A651  B2FF              mov dl,0xff
0000A653  88168032          mov [0x3280],dl
0000A657  E8D3FB            call 0xa22d            ; Get a random number.
0000A65A  80E201            and dl,0x1
0000A65D  7502              jnz 0xa661
0000A65F  B2FF              mov dl,0xff
0000A661  88168132          mov [0x3281],dl
0000A665  EB75              jmp short 0xa6dc
0000A667  90                nop
0000A668  2407              and al,0x7
0000A66A  7570              jnz 0xa6dc
0000A66C  A0ED32            mov al,[0x32ed]
0000A66F  A28032            mov [0x3280],al
0000A672  A0EE32            mov al,[0x32ee]
0000A675  A28132            mov [0x3281],al
0000A678  EB62              jmp short 0xa6dc
0000A67A  90                nop
0000A67B  C606813201        mov byte [0x3281],0x1
0000A680  8BC3              mov ax,bx
0000A682  B103              mov cl,0x3
0000A684  D3E0              shl ax,cl
0000A686  39067D32          cmp [0x327d],ax
0000A68A  740D              jz 0xa699
0000A68C  B201              mov dl,0x1
0000A68E  7202              jc 0xa692
0000A690  B2FF              mov dl,0xff
0000A692  88168032          mov [0x3280],dl
0000A696  EB44              jmp short 0xa6dc
0000A698  90                nop
0000A699  C606803200        mov byte [0x3280],0x0
0000A69E  803E7F32A5        cmp byte [0x327f],0xa5
0000A6A3  7537              jnz 0xa6dc
0000A6A5  C606813200        mov byte [0x3281],0x0
0000A6AA  833E7A3206        cmp word [0x327a],byte +0x6
0000A6AF  7407              jz 0xa6b8
0000A6B1  833E7A3212        cmp word [0x327a],byte +0x12
0000A6B6  7524              jnz 0xa6dc
0000A6B8  53                push bx
0000A6B9  BEE831            mov si,0x31e8	; Draws the sprite.
0000A6BC  8B3E8232          mov di,[0x3282]	;
0000A6C0  B9021E            mov cx,0x1e02	;
0000A6C3  B800B8            mov ax,0xb800	;
0000A6C6  8EC0              mov es,ax		;
0000A6C8  E802FB            call 0xa1cd		;
0000A6CB  5B                pop bx
0000A6CC  FE8F8E32          dec byte [bx+0x328e]
0000A6D0  8A878E32          mov al,[bx+0x328e]
0000A6D4  E8D801            call 0xa8af
0000A6D7  C606863201        mov byte [0x3286],0x1
0000A6DC  8B0E7D32          mov cx,[0x327d]
0000A6E0  8A167F32          mov dl,[0x327f]
0000A6E4  890EEF32          mov [0x32ef],cx
0000A6E8  8816F132          mov [0x32f1],dl
0000A6EC  803E803201        cmp byte [0x3280],0x1
0000A6F1  7217              jc 0xa70a
0000A6F3  750E              jnz 0xa703
0000A6F5  83C108            add cx,byte +0x8
0000A6F8  81F93101          cmp cx,0x131
0000A6FC  720C              jc 0xa70a
0000A6FE  B93001            mov cx,0x130
0000A701  EB07              jmp short 0xa70a
0000A703  83E908            sub cx,byte +0x8
0000A706  7302              jnc 0xa70a
0000A708  2BC9              sub cx,cx
0000A70A  81E1F8FF          and cx,0xfff8
0000A70E  890E7D32          mov [0x327d],cx
0000A712  803E813201        cmp byte [0x3281],0x1
0000A717  7215              jc 0xa72e
0000A719  750C              jnz 0xa727
0000A71B  80C202            add dl,0x2
0000A71E  80FAA6            cmp dl,0xa6
0000A721  720B              jc 0xa72e
0000A723  B2A5              mov dl,0xa5
0000A725  EB07              jmp short 0xa72e
0000A727  80EA02            sub dl,0x2
0000A72A  7302              jnc 0xa72e
0000A72C  2AD2              sub dl,dl
0000A72E  88167F32          mov [0x327f],dl
0000A732  E8ABF9            call 0xa0e0
0000A735  A38432            mov [0x3284],ax
0000A738  E8AF00            call 0xa7ea
0000A73B  731B              jnc 0xa758
0000A73D  C606803200        mov byte [0x3280],0x0
0000A742  C606813200        mov byte [0x3281],0x0
0000A747  8B0EEF32          mov cx,[0x32ef]
0000A74B  890E7D32          mov [0x327d],cx
0000A74F  8A16F132          mov dl,[0x32f1]
0000A753  88167F32          mov [0x327f],dl
0000A757  C3                ret
0000A758  E8B5EE            call 0x9610
0000A75B  72E0              jc 0xa73d
0000A75D  E87000            call 0xa7d0
0000A760  83067A3202        add word [0x327a],byte +0x2
0000A765  E80100            call 0xa769
0000A768  C3                ret
0000A769  8B1E7A32          mov bx,[0x327a]
0000A76D  8B876032          mov ax,[bx+0x3260]
0000A771  3D0000            cmp ax,0x0
0000A774  7505              jnz 0xa77b
0000A776  A37A32            mov [0x327a],ax
0000A779  EBEE              jmp short 0xa769
0000A77B  8BF0              mov si,ax
0000A77D  8B3E8432          mov di,[0x3284]
0000A781  893E8232          mov [0x3282],di
0000A785  BDE831            mov bp,0x31e8
0000A788  B800B8            mov ax,0xb800
0000A78B  8EC0              mov es,ax
0000A78D  B9021E            mov cx,0x1e02
0000A790  C606863200        mov byte [0x3286],0x0
0000A795  FC                cld
0000A796  882E8932          mov [0x3289],ch
0000A79A  2AED              sub ch,ch
0000A79C  890E8732          mov [0x3287],cx
0000A7A0  8B0E8732          mov cx,[0x3287]
0000A7A4  268B1D            mov bx,[es:di]
0000A7A7  3E895E00          mov [ds:bp+0x0],bx
0000A7AB  AD                lodsw
0000A7AC  0BC3              or ax,bx
0000A7AE  AB                stosw
0000A7AF  83C502            add bp,byte +0x2
0000A7B2  E2F0              loop 0xa7a4
0000A7B4  2B3E8732          sub di,[0x3287]
0000A7B8  2B3E8732          sub di,[0x3287]
0000A7BC  81F70020          xor di,0x2000
0000A7C0  F7C70020          test di,0x2000
0000A7C4  7503              jnz 0xa7c9
0000A7C6  83C750            add di,byte +0x50
0000A7C9  FE0E8932          dec byte [0x3289]
0000A7CD  75D1              jnz 0xa7a0
0000A7CF  C3                ret

0000A7D0  803E863200        cmp byte [0x3286],0x0
0000A7D5  7512              jnz 0xa7e9
0000A7D7  B800B8            mov ax,0xb800		; Draws the sprite.
0000A7DA  8EC0              mov es,ax			;	
0000A7DC  BEE831            mov si,0x31e8		;
0000A7DF  8B3E8232          mov di,[0x3282]		;
0000A7E3  B9021E            mov cx,0x1e02		;
0000A7E6  E8E4F9            call 0xa1cd      		;
0000A7E9  C3                ret

0000A7EA  803EB81C00        cmp byte [0x1cb8],0x0
0000A7EF  7542              jnz 0xa833
0000A7F1  833E040006        cmp word [0x4],byte +0x6
0000A7F6  750B              jnz 0xa803
0000A7F8  803EBD4400        cmp byte [0x44bd],0x0
0000A7FD  7404              jz 0xa803
0000A7FF  E8DE13            call 0xbbe0
0000A802  C3                ret
0000A803  A17D32            mov ax,[0x327d]
0000A806  8A167F32          mov dl,[0x327f]
0000A80A  BE1000            mov si,0x10
0000A80D  8B1E7905          mov bx,[0x579]
0000A811  8A367B05          mov dh,[0x57b]
0000A815  BF1800            mov di,0x18
0000A818  B91E0E            mov cx,0xe1e
0000A81B  E83BFA            call 0xa259
0000A81E  7313              jnc 0xa833
0000A820  833E040004        cmp word [0x4],byte +0x4
0000A825  7507              jnz 0xa82e
0000A827  803EE13900        cmp byte [0x39e1],0x0
0000A82C  7503              jnz 0xa831
0000A82E  E871D4            call 0x7ca2
0000A831  F9                stc
0000A832  C3                ret
0000A833  F8                clc
0000A834  C3                ret
0000A835  FC                cld
0000A836  2BC0              sub ax,ax
0000A838  1E                push ds
0000A839  07                pop es
0000A83A  BF8E32            mov di,0x328e
0000A83D  B91400            mov cx,0x14
0000A840  F3AB              rep stosw
0000A842  C706B632FF00      mov word [0x32b6],0xff
0000A848  C7067A320000      mov word [0x327a],0x0
0000A84E  C7067D320000      mov word [0x327d],0x0
0000A854  C6067F32A0        mov byte [0x327f],0xa0
0000A859  C606863201        mov byte [0x3286],0x1
0000A85E  C606803200        mov byte [0x3280],0x0
0000A863  C606813200        mov byte [0x3281],0x0
0000A868  E8C2F9            call 0xa22d            ; Get a random number.
0000A86B  8816EB32          mov [0x32eb],dl
0000A86F  C606EA326C        mov byte [0x32ea],0x6c
0000A874  C3                ret
0000A875  803E7B05B4        cmp byte [0x57b],0xb4
0000A87A  7232              jc 0xa8ae
0000A87C  803E6E0500        cmp byte [0x56e],0x0
0000A881  742B              jz 0xa8ae
0000A883  A17905            mov ax,[0x579]
0000A886  050C00            add ax,0xc
0000A889  B103              mov cl,0x3
0000A88B  D3E8              shr ax,cl
0000A88D  3D2700            cmp ax,0x27
0000A890  771C              ja 0xa8ae
0000A892  3B06B632          cmp ax,[0x32b6]
0000A896  7416              jz 0xa8ae
0000A898  A3B632            mov [0x32b6],ax
0000A89B  8BD8              mov bx,ax
0000A89D  8A878E32          mov al,[bx+0x328e]
0000A8A1  3C04              cmp al,0x4
0000A8A3  7309              jnc 0xa8ae
0000A8A5  FEC0              inc al
0000A8A7  88878E32          mov [bx+0x328e],al
0000A8AB  E80100            call 0xa8af
0000A8AE  C3                ret

0000A8AF  B40A              mov ah,0xa		; Draws the sprite.
0000A8B1  F6E4              mul ah		;
0000A8B3  05B832            add ax,0x32b8	;
0000A8B6  8BF0              mov si,ax		;
0000A8B8  8BFB              mov di,bx		;
0000A8BA  D1E7              shl di,1		;
0000A8BC  81C7001E          add di,0x1e00	;
0000A8C0  B800B8            mov ax,0xb800	;
0000A8C3  8EC0              mov es,ax		;
0000A8C5  B90105            mov cx,0x501	;
0000A8C8  E802F9            call 0xa1cd		;
0000A8CB  C3                ret

0000A8CC  0000              add [bx+si],al
0000A8CE  0000              add [bx+si],al
0000A8D0  C70611350000      mov word [0x3511],0x0
0000A8D6  C6061B3500        mov byte [0x351b],0x0
0000A8DB  8B1E1135          mov bx,[0x3511]
0000A8DF  80BFA73400        cmp byte [bx+0x34a7],0x0
0000A8E4  7403              jz 0xa8e9
0000A8E6  E9F400            jmp 0xa9dd
0000A8E9  8BF3              mov si,bx
0000A8EB  D1E6              shl si,1
0000A8ED  8B844734          mov ax,[si+0x3447]
0000A8F1  8A977734          mov dl,[bx+0x3477]
0000A8F5  BF0000            mov di,0x0
0000A8F8  83FB0C            cmp bx,byte +0xc
0000A8FB  7203              jc 0xa900
0000A8FD  BF0200            mov di,0x2
0000A900  8BB51335          mov si,[di+0x3513]
0000A904  8B8D1735          mov cx,[di+0x3517]
0000A908  8B1E7905          mov bx,[0x579]
0000A90C  8A367B05          mov dh,[0x57b]
0000A910  BF1800            mov di,0x18
0000A913  B50E              mov ch,0xe
0000A915  E841F9            call 0xa259
0000A918  73CC              jnc 0xa8e6
0000A91A  8B1E1135          mov bx,[0x3511]
0000A91E  83FB0C            cmp bx,byte +0xc
0000A921  727C              jc 0xa99f
0000A923  803E530500        cmp byte [0x553],0x0
0000A928  7575              jnz 0xa99f
0000A92A  803EF30500        cmp byte [0x5f3],0x0
0000A92F  756E              jnz 0xa99f
0000A931  C606520501        mov byte [0x552],0x1
0000A936  8B0E7905          mov cx,[0x579]
0000A93A  83E908            sub cx,byte +0x8
0000A93D  7302              jnc 0xa941
0000A93F  2BC9              sub cx,cx
0000A941  81F91701          cmp cx,0x117
0000A945  7203              jc 0xa94a
0000A947  B91601            mov cx,0x116
0000A94A  8A167B05          mov dl,[0x57b]
0000A94E  80FAB5            cmp dl,0xb5
0000A951  7202              jc 0xa955
0000A953  B2B4              mov dl,0xb4
0000A955  E888F7            call 0xa0e0
0000A958  8BF8              mov di,ax		        ; Draws the ZAP! sprite.
0000A95A  BE5033            mov si,0x3350		;
0000A95D  B800B8            mov ax,0xb800		;
0000A960  8EC0              mov es,ax			;
0000A962  B90512            mov cx,0x1205		;
0000A965  E865F8            call 0xa1cd			;
0000A968  E85C22            call 0xcbc7
0000A96B  2AE4              sub ah,ah
0000A96D  CD1A              int 0x1a
0000A96F  89160935          mov [0x3509],dx
0000A973  52                push dx
0000A974  E85F22            call 0xcbd6
0000A977  E88EDE            call 0x8808   ; Get vertical retrace status.
0000A97A  74F8              jz 0xa974
0000A97C  E85722            call 0xcbd6
0000A97F  5A                pop dx
0000A980  BB0100            mov bx,0x1   ;
0000A983  F6C201            test dl,0x1  ; ???
0000A986  7502              jnz 0xa98a   ; ???
0000A988  B30F              mov bl,0xf   ;
0000A98A  B40B              mov ah,0xb   ;
0000A98C  CD10              int 0x10     ;
0000A98E  E84522            call 0xcbd6
0000A991  2AE4              sub ah,ah
0000A993  CD1A              int 0x1a
0000A995  2B160935          sub dx,[0x3509]
0000A999  83FA0D            cmp dx,byte +0xd
0000A99C  72D5              jc 0xa973
0000A99E  C3                ret
0000A99F  FE061B35          inc byte [0x351b]
0000A9A3  B8DC05            mov ax,0x5dc
0000A9A6  BB2504            mov bx,0x425
0000A9A9  E8BF23            call 0xcd6b
0000A9AC  803E1B3501        cmp byte [0x351b],0x1
0000A9B1  7503              jnz 0xa9b6
0000A9B3  E85DDC            call 0x8613
0000A9B6  8B1E1135          mov bx,[0x3511]
0000A9BA  E83402            call 0xabf1
0000A9BD  8B1E1135          mov bx,[0x3511]
0000A9C1  C687A73401        mov byte [bx+0x34a7],0x1
0000A9C6  83FB0C            cmp bx,byte +0xc
0000A9C9  7312              jnc 0xa9dd
0000A9CB  FE0E1034          dec byte [0x3410]
0000A9CF  750C              jnz 0xa9dd
0000A9D1  803EF30500        cmp byte [0x5f3],0x0
0000A9D6  7505              jnz 0xa9dd
0000A9D8  C606530501        mov byte [0x553],0x1
0000A9DD  FF061135          inc word [0x3511]
0000A9E1  833E113518        cmp word [0x3511],byte +0x18
0000A9E6  7303              jnc 0xa9eb
0000A9E8  E9F0FE            jmp 0xa8db
0000A9EB  803E1B3500        cmp byte [0x351b],0x0
0000A9F0  7405              jz 0xa9f7
0000A9F2  E87800            call 0xaa6d
0000A9F5  F9                stc
0000A9F6  C3                ret

0000A9F7  F8                clc
0000A9F8  C3                ret
0000A9F9  C70611340000      mov word [0x3411],0x0
0000A9FF  C70615340000      mov word [0x3415],0x0
0000AA05  C60610340C        mov byte [0x3410],0xc
0000AA0A  B91800            mov cx,0x18
0000AA0D  8BD9              mov bx,cx
0000AA0F  4B                dec bx
0000AA10  C6878F3401        mov byte [bx+0x348f],0x1
0000AA15  C687A73400        mov byte [bx+0x34a7],0x0
0000AA1A  8A87F134          mov al,[bx+0x34f1]
0000AA1E  88877734          mov [bx+0x3477],al
0000AA22  C6872F3401        mov byte [bx+0x342f],0x1
0000AA27  E803F8            call 0xa22d            ; Get a random number.
0000AA2A  80E201            and dl,0x1
0000AA2D  7502              jnz 0xaa31
0000AA2F  F6D2              not dl
0000AA31  88971734          mov [bx+0x3417],dl
0000AA35  D1E3              shl bx,1
0000AA37  E8F3F7            call 0xa22d            ; Get a random number.
0000AA3A  2AF6              sub dh,dh
0000AA3C  89974734          mov [bx+0x3447],dx
0000AA40  E2CB              loop 0xaa0d
0000AA42  8B1E0800          mov bx,[0x8]
0000AA46  8A8F1C35          mov cl,[bx+0x351c]
0000AA4A  2AED              sub ch,ch
0000AA4C  E8DEF7            call 0xa22d            ; Get a random number.
0000AA4F  80E20F            and dl,0xf
0000AA52  80FA0C            cmp dl,0xc
0000AA55  73F5              jnc 0xaa4c
0000AA57  8ADA              mov bl,dl
0000AA59  80C30C            add bl,0xc
0000AA5C  2AFF              sub bh,bh
0000AA5E  80BFA73400        cmp byte [bx+0x34a7],0x0
0000AA63  75E7              jnz 0xaa4c
0000AA65  C687A73401        mov byte [bx+0x34a7],0x1
0000AA6A  E2E0              loop 0xaa4c
0000AA6C  C3                ret
0000AA6D  B90C00            mov cx,0xc
0000AA70  8BD9              mov bx,cx
0000AA72  83C30B            add bx,byte +0xb
0000AA75  80BFA73400        cmp byte [bx+0x34a7],0x0
0000AA7A  7426              jz 0xaaa2
0000AA7C  2BC0              sub ax,ax
0000AA7E  B201              mov dl,0x1
0000AA80  8887A734          mov [bx+0x34a7],al
0000AA84  813E7905A000      cmp word [0x579],0xa0
0000AA8A  7705              ja 0xaa91
0000AA8C  B82E01            mov ax,0x12e
0000AA8F  B2FF              mov dl,0xff
0000AA91  88971734          mov [bx+0x3417],dl
0000AA95  D0E3              shl bl,1
0000AA97  89874734          mov [bx+0x3447],ax
0000AA9B  FE0E1B35          dec byte [0x351b]
0000AA9F  75CC              jnz 0xaa6d
0000AAA1  C3                ret
0000AAA2  E2CC              loop 0xaa70
0000AAA4  C3                ret
0000AAA5  2AE4              sub ah,ah
0000AAA7  CD1A              int 0x1a
0000AAA9  3B160935          cmp dx,[0x3509]
0000AAAD  7501              jnz 0xaab0
0000AAAF  C3                ret
0000AAB0  89160B35          mov [0x350b],dx
0000AAB4  FF061534          inc word [0x3415]
0000AAB8  8B1E1534          mov bx,[0x3415]
0000AABC  83FB18            cmp bx,byte +0x18
0000AABF  7213              jc 0xaad4
0000AAC1  2BDB              sub bx,bx
0000AAC3  891E1534          mov [0x3415],bx
0000AAC7  813611340C00      xor word [0x3411],0xc
0000AACD  8306133408        add word [0x3413],byte +0x8
0000AAD2  EB13              jmp short 0xaae7
0000AAD4  83FB0C            cmp bx,byte +0xc
0000AAD7  7514              jnz 0xaaed
0000AAD9  803E9706FD        cmp byte [0x697],0xfd	     ; Check for PCJr.
0000AADE  7507              jnz 0xaae7
0000AAE0  803E7B0530        cmp byte [0x57b],0x30
0000AAE5  7206              jc 0xaaed
0000AAE7  A10B35            mov ax,[0x350b]
0000AAEA  A30935            mov [0x3509],ax
0000AAED  8BF3              mov si,bx
0000AAEF  D1E6              shl si,1
0000AAF1  80BFA73400        cmp byte [bx+0x34a7],0x0
0000AAF6  75B7              jnz 0xaaaf
0000AAF8  E832F7            call 0xa22d            ; Get a random number.
0000AAFB  80FA10            cmp dl,0x10
0000AAFE  7719              ja 0xab19
0000AB00  80E201            and dl,0x1
0000AB03  7502              jnz 0xab07
0000AB05  F6D2              not dl
0000AB07  88971734          mov [bx+0x3417],dl
0000AB0B  E81FF7            call 0xa22d            ; Get a random number.
0000AB0E  80E201            and dl,0x1
0000AB11  7502              jnz 0xab15
0000AB13  F6D2              not dl
0000AB15  88972F34          mov [bx+0x342f],dl
0000AB19  B90400            mov cx,0x4
0000AB1C  83FB0C            cmp bx,byte +0xc
0000AB1F  7202              jc 0xab23
0000AB21  D0E9              shr cl,1
0000AB23  8B844734          mov ax,[si+0x3447]
0000AB27  80BF173401        cmp byte [bx+0x3417],0x1
0000AB2C  740D              jz 0xab3b
0000AB2E  2BC1              sub ax,cx
0000AB30  7318              jnc 0xab4a
0000AB32  2BC0              sub ax,ax
0000AB34  C687173401        mov byte [bx+0x3417],0x1
0000AB39  EB0F              jmp short 0xab4a
0000AB3B  03C1              add ax,cx
0000AB3D  3D2F01            cmp ax,0x12f
0000AB40  7208              jc 0xab4a
0000AB42  B82E01            mov ax,0x12e
0000AB45  C6871734FF        mov byte [bx+0x3417],0xff
0000AB4A  89844734          mov [si+0x3447],ax
0000AB4E  8A877734          mov al,[bx+0x3477]
0000AB52  80BF2F3401        cmp byte [bx+0x342f],0x1
0000AB57  7413              jz 0xab6c
0000AB59  FEC8              dec al
0000AB5B  3A87F134          cmp al,[bx+0x34f1]
0000AB5F  731F              jnc 0xab80
0000AB61  8A87F134          mov al,[bx+0x34f1]
0000AB65  C6872F3401        mov byte [bx+0x342f],0x1
0000AB6A  EB14              jmp short 0xab80
0000AB6C  FEC0              inc al
0000AB6E  8A97F134          mov dl,[bx+0x34f1]
0000AB72  80C218            add dl,0x18
0000AB75  3AC2              cmp al,dl
0000AB77  7607              jna 0xab80
0000AB79  8AC2              mov al,dl
0000AB7B  C6872F34FF        mov byte [bx+0x342f],0xff
0000AB80  88877734          mov [bx+0x3477],al
0000AB84  8AD0              mov dl,al
0000AB86  8B8C4734          mov cx,[si+0x3447]
0000AB8A  E853F5            call 0xa0e0
0000AB8D  A3EF34            mov [0x34ef],ax
0000AB90  8B1E1534          mov bx,[0x3415]
0000AB94  E85A00            call 0xabf1
0000AB97  8B1E1534          mov bx,[0x3415]		;
0000AB9B  8BF3              mov si,bx			;
0000AB9D  D1E6              shl si,1			;
0000AB9F  8B3EEF34          mov di,[0x34ef]		;
0000ABA3  89BCBF34          mov [si+0x34bf],di		;
0000ABA7  C6878F3400        mov byte [bx+0x348f],0x0	;
0000ABAC  B800B8            mov ax,0xb800		;
0000ABAF  8EC0              mov es,ax			;
0000ABB1  83FB0C            cmp bx,byte +0xc		; ???
0000ABB4  7219              jc 0xabcf			; ???
0000ABB6  8BF3              mov si,bx			; Draw the unknown sprite on the fence.
0000ABB8  B103              mov cl,0x3			;
0000ABBA  D3E6              shl si,cl			;
0000ABBC  03361334          add si,[0x3413]		;
0000ABC0  81E61800          and si,0x18			;
0000ABC4  81C63033          add si,0x3330		;
0000ABC8  B90202            mov cx,0x202		;
0000ABCB  E8FFF5            call 0xa1cd                 ;
0000ABCE  C3                ret

0000ABCF  8B361134          mov si,[0x3411]		; Draws the fish facing either left or right sprite.
0000ABD3  F6C301            test bl,0x1			;
0000ABD6  7504              jnz 0xabdc			;
0000ABD8  81F60C00          xor si,0xc			;
0000ABDC  80BF173401        cmp byte [bx+0x3417],0x1	; ???
0000ABE1  7403              jz 0xabe6			;
0000ABE3  83C618            add si,byte +0x18		;
0000ABE6  81C60033          add si,0x3300		;
0000ABEA  B90106            mov cx,0x601		;
0000ABED  E8DDF5            call 0xa1cd			;
0000ABF0  C3                ret

0000ABF1  80BF8F3400        cmp byte [bx+0x348f],0x0
0000ABF6  751C              jnz 0xac14
0000ABF8  D1E3              shl bx,1			; Draws the sprite.
0000ABFA  BE0434            mov si,0x3404		;
0000ABFD  8BBFBF34          mov di,[bx+0x34bf]		;
0000AC01  B800B8            mov ax,0xb800		;
0000AC04  8EC0              mov es,ax			;
0000AC06  B90106            mov cx,0x601		;
0000AC09  83FB18            cmp bx,byte +0x18		;
0000AC0C  7203              jc 0xac11			;
0000AC0E  B90202            mov cx,0x202		;
0000AC11  E8B9F5            call 0xa1cd                 ;
0000AC14  C3                ret

0000AC15  2AE4              sub ah,ah
0000AC17  CD1A              int 0x1a
0000AC19  8BC2              mov ax,dx
0000AC1B  2B060F35          sub ax,[0x350f]
0000AC1F  3D0800            cmp ax,0x8
0000AC22  7256              jc 0xac7a
0000AC24  FF060D35          inc word [0x350d]
0000AC28  8B1E0D35          mov bx,[0x350d]
0000AC2C  83FB28            cmp bx,byte +0x28
0000AC2F  720A              jc 0xac3b
0000AC31  2BDB              sub bx,bx
0000AC33  891E0D35          mov [0x350d],bx
0000AC37  89160F35          mov [0x350f],dx
0000AC3B  8BFB              mov di,bx
0000AC3D  D1E7              shl di,1
0000AC3F  803E7B0507        cmp byte [0x57b],0x7
0000AC44  7713              ja 0xac59
0000AC46  A17905            mov ax,[0x579]
0000AC49  B102              mov cl,0x2
0000AC4B  D3E8              shr ax,cl
0000AC4D  40                inc ax
0000AC4E  2BC7              sub ax,di
0000AC50  7302              jnc 0xac54
0000AC52  F7D0              not ax
0000AC54  3D0400            cmp ax,0x4
0000AC57  7221              jc 0xac7a
0000AC59  81C7A000          add di,0xa0			; Draws the unknown sprite.
0000AC5D  8A875626          mov al,[bx+0x2656]		;
0000AC61  0408              add al,0x8			;
0000AC63  88875626          mov [bx+0x2656],al		;
0000AC67  251800            and ax,0x18			;
0000AC6A  052020            add ax,0x2020		;
0000AC6D  8BF0              mov si,ax			;
0000AC6F  B800B8            mov ax,0xb800		;
0000AC72  8EC0              mov es,ax			;
0000AC74  B90104            mov cx,0x401		;
0000AC77  E853F5            call 0xa1cd                 ;
0000AC7A  C3                ret

0000AC7B  0000              add [bx+si],al
0000AC7D  0000              add [bx+si],al
0000AC7F  002A              add [bp+si],ch
0000AC81  E4CD              in al,0xcd
0000AC83  1A8BC22B          sbb cl,[bp+di+0x2bc2]
0000AC87  06                push es
0000AC88  DA35              fidiv dword [di]
0000AC8A  3D0600            cmp ax,0x6
0000AC8D  7301              jnc 0xac90
0000AC8F  C3                ret

0000AC90  8916DA35          mov [0x35da],dx		; Draws the sprite.
0000AC94  8306D83502        add word [0x35d8],byte +0x2	;
0000AC99  8B1ED835          mov bx,[0x35d8]		;
0000AC9D  81E30600          and bx,0x6			;
0000ACA1  8BB7D035          mov si,[bx+0x35d0]		;
0000ACA5  BFC915            mov di,0x15c9		;
0000ACA8  B800B8            mov ax,0xb800		;
0000ACAB  8EC0              mov es,ax			;
0000ACAD  B9020A            mov cx,0xa02		;
0000ACB0  E81AF5            call 0xa1cd			;
0000ACB3  B8E400            mov ax,0xe4
0000ACB6  B28A              mov dl,0x8a
0000ACB8  BE1000            mov si,0x10
0000ACBB  8B1E7905          mov bx,[0x579]
0000ACBF  8A367B05          mov dh,[0x57b]
0000ACC3  BF1800            mov di,0x18
0000ACC6  B90A0E            mov cx,0xe0a
0000ACC9  E88DF5            call 0xa259
0000ACCC  7305              jnc 0xacd3
0000ACCE  C606540501        mov byte [0x554],0x1
0000ACD3  C3                ret

0000ACD4  0000              add [bx+si],al
0000ACD6  0000              add [bx+si],al
0000ACD8  0000              add [bx+si],al
0000ACDA  0000              add [bx+si],al
0000ACDC  0000              add [bx+si],al
0000ACDE  0000              add [bx+si],al
0000ACE0  833E060007        cmp word [0x6],byte +0x7
0000ACE5  7503              jnz 0xacea
0000ACE7  EB1A              jmp short 0xad03
0000ACE9  90                nop
0000ACEA  FF061404          inc word [0x414]
0000ACEE  C606180401        mov byte [0x418],0x1
0000ACF3  BAAAAA            mov dx,0xaaaa
0000ACF6  E8CD01            call 0xaec6
0000ACF9  2BC0              sub ax,ax
0000ACFB  C6069F3600        mov byte [0x369f],0x0
0000AD00  E8D901            call 0xaedc
0000AD03  2AE4              sub ah,ah
0000AD05  CD1A              int 0x1a
0000AD07  833E060007        cmp word [0x6],byte +0x7
0000AD0C  7511              jnz 0xad1f
0000AD0E  2B161204          sub dx,[0x412]
0000AD12  B8302A            mov ax,0x2a30
0000AD15  2BC2              sub ax,dx
0000AD17  7302              jnc 0xad1b
0000AD19  2BC0              sub ax,ax
0000AD1B  D1E8              shr ax,1
0000AD1D  EB1F              jmp short 0xad3e
0000AD1F  2B161004          sub dx,[0x410]
0000AD23  B84605            mov ax,0x546
0000AD26  833E060006        cmp word [0x6],byte +0x6
0000AD2B  7502              jnz 0xad2f
0000AD2D  D1E0              shl ax,1
0000AD2F  2BC2              sub ax,dx
0000AD31  7302              jnc 0xad35
0000AD33  2BC0              sub ax,ax
0000AD35  833E060006        cmp word [0x6],byte +0x6
0000AD3A  7402              jz 0xad3e
0000AD3C  D1E0              shl ax,1
0000AD3E  A39736            mov [0x3697],ax
0000AD41  E8E001            call 0xaf24
0000AD44  8B1E0600          mov bx,[0x6]
0000AD48  D0E3              shl bl,1
0000AD4A  8BB7CC36          mov si,[bx+0x36cc]
0000AD4E  BF8D36            mov di,0x368d
0000AD51  E8FAED            call 0x9b4e
0000AD54  833E060007        cmp word [0x6],byte +0x7
0000AD59  7543              jnz 0xad9e
0000AD5B  8B1E0800          mov bx,[0x8]
0000AD5F  D0E3              shl bl,1
0000AD61  8BC3              mov ax,bx
0000AD63  8B8FDC36          mov cx,[bx+0x36dc]
0000AD67  833E8D2E08        cmp word [0x2e8d],byte +0x8
0000AD6C  7305              jnc 0xad73
0000AD6E  D1E1              shl cx,1
0000AD70  051000            add ax,0x10
0000AD73  A30C37            mov [0x370c],ax
0000AD76  BE8D36            mov si,0x368d
0000AD79  BF821F            mov di,0x1f82
0000AD7C  51                push cx
0000AD7D  E8CEED            call 0x9b4e
0000AD80  59                pop cx
0000AD81  E2F3              loop 0xad76
0000AD83  E8A400            call 0xae2a
0000AD86  C6069E3638        mov byte [0x369e],0x38
0000AD8B  C606993601        mov byte [0x3699],0x1
0000AD90  C70622374400      mov word [0x3722],0x44
0000AD96  E8D100            call 0xae6a
0000AD99  E80001            call 0xae9c
0000AD9C  EB39              jmp short 0xadd7
0000AD9E  BE8D36            mov si,0x368d
0000ADA1  BF821F            mov di,0x1f82
0000ADA4  E8A7ED            call 0x9b4e
0000ADA7  C606993602        mov byte [0x3699],0x2
0000ADAC  C70622371E00      mov word [0x3722],0x1e
0000ADB2  BAFFFF            mov dx,0xffff
0000ADB5  E80E01            call 0xaec6
0000ADB8  B88C0A            mov ax,0xa8c
0000ADBB  2B069736          sub ax,[0x3697]
0000ADBF  B104              mov cl,0x4
0000ADC1  D3E8              shr ax,cl
0000ADC3  24F0              and al,0xf0
0000ADC5  A29E36            mov [0x369e],al
0000ADC8  B428              mov ah,0x28
0000ADCA  F6E4              mul ah
0000ADCC  C6069F3601        mov byte [0x369f],0x1
0000ADD1  E80801            call 0xaedc
0000ADD4  E89300            call 0xae6a
0000ADD7  2AE4              sub ah,ah
0000ADD9  CD1A              int 0x1a
0000ADDB  89169536          mov [0x3695],dx
0000ADDF  833E060007        cmp word [0x6],byte +0x7
0000ADE4  7505              jnz 0xadeb
0000ADE6  E8AA21            call 0xcf93
0000ADE9  EB03              jmp short 0xadee
0000ADEB  E8771E            call 0xcc65
0000ADEE  E85B00            call 0xae4c
0000ADF1  2B169536          sub dx,[0x3695]
0000ADF5  3B162237          cmp dx,[0x3722]
0000ADF9  72E4              jc 0xaddf
0000ADFB  2BDB              sub bx,bx   ; Black background.
0000ADFD  B40B              mov ah,0xb  ;
0000ADFF  CD10              int 0x10    ;
0000AE01  833E060007        cmp word [0x6],byte +0x7
0000AE06  7404              jz 0xae0c
0000AE08  E84621            call 0xcf51		; Turn off the PC-Speaker.
0000AE0B  C3                ret

0000AE0C  B800B8            mov ax,0xb800	; Draws the sprite.
0000AE0F  8EC0              mov es,ax		;
0000AE11  BE0E00            mov si,0xe		;
0000AE14  BFE408            mov di,0x8e4	;
0000AE17  B90408            mov cx,0x804	;
0000AE1A  E8B0F3            call 0xa1cd		;
0000AE1D  BE4E00            mov si,0x4e		; Draws the sprite.
0000AE20  BF940C            mov di,0xc94	;
0000AE23  B91408            mov cx,0x814	;
0000AE26  E8A4F3            call 0xa1cd         ;
0000AE29  C3                ret

0000AE2A  1E                push ds
0000AE2B  07                pop es
0000AE2C  B800B8            mov ax,0xb800
0000AE2F  8ED8              mov ds,ax
0000AE31  B90408            mov cx,0x804
0000AE34  BF0E00            mov di,0xe
0000AE37  BEE408            mov si,0x8e4
0000AE3A  E8BDF3            call 0xa1fa
0000AE3D  B91408            mov cx,0x814
0000AE40  BF4E00            mov di,0x4e
0000AE43  BE940C            mov si,0xc94
0000AE46  E8B1F3            call 0xa1fa
0000AE49  06                push es
0000AE4A  1F                pop ds
0000AE4B  C3                ret

0000AE4C  2AE4              sub ah,ah
0000AE4E  CD1A              int 0x1a
0000AE50  52                push dx
0000AE51  E8B4D9            call 0x8808   ; Get vertical retrace status.
0000AE54  74FB              jz 0xae51
0000AE56  5A                pop dx
0000AE57  52                push dx
0000AE58  2BDB              sub bx,bx       ; Change background color.
0000AE5A  F7C20400          test dx,0x4     ; ???
0000AE5E  7504              jnz 0xae64      ; ???
0000AE60  8A1E9936          mov bl,[0x3699] ;
0000AE64  B40B              mov ah,0xb      ;
0000AE66  CD10              int 0x10        ;
0000AE68  5A                pop dx
0000AE69  C3                ret

0000AE6A  B402              mov ah,0x2       ; Set cursor. ???
0000AE6C  8A369E36          mov dh,[0x369e]  ;
0000AE70  B103              mov cl,0x3       ;
0000AE72  D2EE              shr dh,cl        ;
0000AE74  B212              mov dl,0x12      ;
0000AE76  2AFF              sub bh,bh        ;
0000AE78  CD10              int 0x10         ;
0000AE7A  C706A0360300      mov word [0x36a0],0x3
0000AE80  8B1EA036          mov bx,[0x36a0]
0000AE84  8A878D36          mov al,[bx+0x368d]
0000AE88  0430              add al,0x30
0000AE8A  B40E              mov ah,0xe     ; Teletype.
0000AE8C  B303              mov bl,0x3     ;
0000AE8E  CD10              int 0x10       ;
0000AE90  FF06A036          inc word [0x36a0]
0000AE94  833EA03607        cmp word [0x36a0],byte +0x7
0000AE99  72E5              jc 0xae80
0000AE9B  C3                ret

0000AE9C  B402              mov ah,0x2    ; Set cursor.
0000AE9E  B20A              mov dl,0xa    ;
0000AEA0  8AF2              mov dh,dl     ;
0000AEA2  2BDB              sub bx,bx     ;
0000AEA4  CD10              int 0x10      ;
0000AEA6  8B1E0C37          mov bx,[0x370c]
0000AEAA  8B87EC36          mov ax,[bx+0x36ec]
0000AEAE  A32037            mov [0x3720],ax
0000AEB1  2BDB              sub bx,bx
0000AEB3  B40E              mov ah,0xe
0000AEB5  8A870E37          mov al,[bx+0x370e]
0000AEB9  53                push bx
0000AEBA  B303              mov bl,0x3
0000AEBC  CD10              int 0x10
0000AEBE  5B                pop bx
0000AEBF  43                inc bx
0000AEC0  83FB14            cmp bx,byte +0x14
0000AEC3  72EE              jc 0xaeb3
0000AEC5  C3                ret
0000AEC6  FC                cld
0000AEC7  B81000            mov ax,0x10
0000AECA  8EC0              mov es,ax
0000AECC  BF0E00            mov di,0xe
0000AECF  BEE035            mov si,0x35e0
0000AED2  B91E00            mov cx,0x1e
0000AED5  AD                lodsw
0000AED6  23C2              and ax,dx
0000AED8  AB                stosw
0000AED9  E2FA              loop 0xaed5
0000AEDB  C3                ret
0000AEDC  A39A36            mov [0x369a],ax
0000AEDF  B800B8            mov ax,0xb800
0000AEE2  8EC0              mov es,ax
0000AEE4  E8721D            call 0xcc59
0000AEE7  B8801B            mov ax,0x1b80
0000AEEA  BB1C36            mov bx,0x361c
0000AEED  A39C36            mov [0x369c],ax
0000AEF0  E861F0            call 0x9f54 ; Call interleaved scanline renderer.
0000AEF3  803E9F3600        cmp byte [0x369f],0x0
0000AEF8  7418              jz 0xaf12
0000AEFA  E89C1D            call 0xcc99
0000AEFD  2AE4              sub ah,ah
0000AEFF  CD1A              int 0x1a
0000AF01  89169536          mov [0x3695],dx
0000AF05  2AE4              sub ah,ah
0000AF07  CD1A              int 0x1a
0000AF09  2B169536          sub dx,[0x3695]
0000AF0D  83FA02            cmp dx,byte +0x2
0000AF10  72F3              jc 0xaf05
0000AF12  A19C36            mov ax,[0x369c]
0000AF15  2D8002            sub ax,0x280
0000AF18  7206              jc 0xaf20
0000AF1A  3B069A36          cmp ax,[0x369a]
0000AF1E  73CA              jnc 0xaeea
0000AF20  E82E20            call 0xcf51		; Turn off the PC-Speaker.
0000AF23  C3                ret
0000AF24  A38B36            mov [0x368b],ax
0000AF27  2BC0              sub ax,ax
0000AF29  A38D36            mov [0x368d],ax
0000AF2C  A38F36            mov [0x368f],ax
0000AF2F  A39136            mov [0x3691],ax
0000AF32  A39336            mov [0x3693],ax
0000AF35  BB8436            mov bx,0x3684
0000AF38  BA0010            mov dx,0x1000
0000AF3B  85168B36          test [0x368b],dx
0000AF3F  7408              jz 0xaf49
0000AF41  8BF3              mov si,bx
0000AF43  BF8D36            mov di,0x368d
0000AF46  E805EC            call 0x9b4e
0000AF49  83EB07            sub bx,byte +0x7
0000AF4C  D1EA              shr dx,1
0000AF4E  73EB              jnc 0xaf3b
0000AF50  C3                ret

0000AF5F  00C6              add dh,al
0000AF61  06                push es
0000AF62  AF                scasw
0000AF63  37                aaa
0000AF64  03B80100          add di,[bx+si+0x1]
0000AF68  A3B037            mov [0x37b0],ax
0000AF6B  A3B237            mov [0x37b2],ax
0000AF6E  A3B437            mov [0x37b4],ax
0000AF71  C3                ret

0000AF72  2AE4              sub ah,ah
0000AF74  CD1A              int 0x1a
0000AF76  3B16B837          cmp dx,[0x37b8]
0000AF7A  7501              jnz 0xaf7d
0000AF7C  C3                ret
0000AF7D  8916B837          mov [0x37b8],dx
0000AF81  C706B6370400      mov word [0x37b6],0x4
0000AF87  8B1EB637          mov bx,[0x37b6]
0000AF8B  83BFB03700        cmp word [bx+0x37b0],byte +0x0
0000AF90  7439              jz 0xafcb
0000AF92  8B87A337          mov ax,[bx+0x37a3]
0000AF96  B218              mov dl,0x18
0000AF98  BE1000            mov si,0x10
0000AF9B  8B1E7905          mov bx,[0x579]
0000AF9F  8A367B05          mov dh,[0x57b]
0000AFA3  BF1800            mov di,0x18
0000AFA6  B9100E            mov cx,0xe10
0000AFA9  E8ADF2            call 0xa259
0000AFAC  731D              jnc 0xafcb
0000AFAE  B8000C            mov ax,0xc00
0000AFB1  BBFD08            mov bx,0x8fd
0000AFB4  E8B41D            call 0xcd6b
0000AFB7  E859D6            call 0x8613
0000AFBA  E8AB02            call 0xb268
0000AFBD  8B1EB637          mov bx,[0x37b6]
0000AFC1  E80F00            call 0xafd3
0000AFC4  E88DD5            call 0x8554
0000AFC7  E87A02            call 0xb244
0000AFCA  C3                ret

0000AFCB  832EB63702        sub word [0x37b6],byte +0x2
0000AFD0  73B5              jnc 0xaf87
0000AFD2  C3                ret
0000AFD3  C787B0370000      mov word [bx+0x37b0],0x0
0000AFD9  1E                push ds
0000AFDA  07                pop es
0000AFDB  FC                cld
0000AFDC  B8AAAA            mov ax,0xaaaa
0000AFDF  BF0E00            mov di,0xe
0000AFE2  8BF7              mov si,di
0000AFE4  B92000            mov cx,0x20
0000AFE7  F3AB              rep stosw
0000AFE9  8BBFA937          mov di,[bx+0x37a9]	; Draws the unknown sprite.
0000AFED  B800B8            mov ax,0xb800	;
0000AFF0  8EC0              mov es,ax		;
0000AFF2  B90210            mov cx,0x1002	;
0000AFF5  E8D5F1            call 0xa1cd		;
0000AFF8  FE0EAF37          dec byte [0x37af]
0000AFFC  750C              jnz 0xb00a
0000AFFE  803E520500        cmp byte [0x552],0x0
0000B003  7505              jnz 0xb00a
0000B005  C606530501        mov byte [0x553],0x1
0000B00A  C3                ret

0000B00B  B800B8            mov ax,0xb800		; Draws the sprite.
0000B00E  8EC0              mov es,ax			;
0000B010  C706A0376A06      mov word [0x37a0],0x66a	;
0000B016  B91000            mov cx,0x10			;
0000B019  2BC0              sub ax,ax			;
0000B01B  8BD8              mov bx,ax			;
0000B01D  A2A237            mov [0x37a2],al		;
0000B020  2AE4              sub ah,ah			;
0000B022  053037            add ax,0x3730		;
0000B025  8BF0              mov si,ax			;
0000B027  8B3EA037          mov di,[0x37a0]		;
0000B02B  03FB              add di,bx			;
0000B02D  51                push cx			;
0000B02E  B90108            mov cx,0x801		;
0000B031  53                push bx			;
0000B032  E898F1            call 0xa1cd			;
0000B035  5B                pop bx
0000B036  59                pop cx
0000B037  83C302            add bx,byte +0x2
0000B03A  83FB1E            cmp bx,byte +0x1e
0000B03D  720F              jc 0xb04e
0000B03F  7504              jnz 0xb045
0000B041  B020              mov al,0x20
0000B043  EBD8              jmp short 0xb01d
0000B045  8106A0374001      add word [0x37a0],0x140
0000B04B  E2CC              loop 0xb019
0000B04D  C3                ret
0000B04E  803EA23750        cmp byte [0x37a2],0x50
0000B053  7411              jz 0xb066
0000B055  F6C101            test cl,0x1
0000B058  750C              jnz 0xb066
0000B05A  E8D0F1            call 0xa22d            ; Get a random number.
0000B05D  80FA40            cmp dl,0x40
0000B060  7204              jc 0xb066
0000B062  B010              mov al,0x10
0000B064  EBB7              jmp short 0xb01d
0000B066  E8C4F1            call 0xa22d            ; Get a random number.
0000B069  8AC2              mov al,dl
0000B06B  2AC3              sub al,bl
0000B06D  2430              and al,0x30
0000B06F  0430              add al,0x30
0000B071  EBAA              jmp short 0xb01d
0000B073  A17905            mov ax,[0x579]
0000B076  25FCFF            and ax,0xfffc
0000B079  3DA400            cmp ax,0xa4
0000B07C  7231              jc 0xb0af
0000B07E  3D1801            cmp ax,0x118
0000B081  772C              ja 0xb0af
0000B083  8A167B05          mov dl,[0x57b]
0000B087  80EA02            sub dl,0x2
0000B08A  80E2F8            and dl,0xf8
0000B08D  F6C208            test dl,0x8
0000B090  741D              jz 0xb0af
0000B092  80FA28            cmp dl,0x28
0000B095  7218              jc 0xb0af
0000B097  80FAA0            cmp dl,0xa0
0000B09A  7713              ja 0xb0af
0000B09C  A37905            mov [0x579],ax
0000B09F  80C202            add dl,0x2
0000B0A2  88167B05          mov [0x57b],dl
0000B0A6  80C232            add dl,0x32
0000B0A9  88167C05          mov [0x57c],dl
0000B0AD  F9                stc
0000B0AE  C3                ret
0000B0AF  F8                clc
0000B0B0  C3                ret
0000B0B1  0000              add [bx+si],al
0000B0B3  0000              add [bx+si],al
0000B0B5  0000              add [bx+si],al
0000B0B7  0000              add [bx+si],al
0000B0B9  0000              add [bx+si],al
0000B0BB  0000              add [bx+si],al
0000B0BD  0000              add [bx+si],al
0000B0BF  00C6              add dh,al
0000B0C1  06                push es
0000B0C2  663908            cmp [bx+si],ecx
0000B0C5  C6066A3901        mov byte [0x396a],0x1
0000B0CA  C606673900        mov byte [0x3967],0x0
0000B0CF  C6066D3902        mov byte [0x396d],0x2
0000B0D4  C70664391801      mov word [0x3964],0x118
0000B0DA  C7066B390000      mov word [0x396b],0x0
0000B0E0  C3                ret
0000B0E1  2AE4              sub ah,ah
0000B0E3  CD1A              int 0x1a
0000B0E5  8BC2              mov ax,dx
0000B0E7  2B06C839          sub ax,[0x39c8]
0000B0EB  3D0200            cmp ax,0x2
0000B0EE  7301              jnc 0xb0f1
0000B0F0  C3                ret
0000B0F1  8916C839          mov [0x39c8],dx
0000B0F5  E88A01            call 0xb282
0000B0F8  72F6              jc 0xb0f0
0000B0FA  E8A101            call 0xb29e
0000B0FD  7303              jnc 0xb102
0000B0FF  E9BE00            jmp 0xb1c0
0000B102  8B1E0800          mov bx,[0x8]
0000B106  D0E3              shl bl,1
0000B108  8B87CC39          mov ax,[bx+0x39cc]
0000B10C  A3C639            mov [0x39c6],ax
0000B10F  A16439            mov ax,[0x3964]
0000B112  A3C339            mov [0x39c3],ax
0000B115  8A166639          mov dl,[0x3966]
0000B119  8816C539          mov [0x39c5],dl
0000B11D  80FA08            cmp dl,0x8
0000B120  7533              jnz 0xb155
0000B122  25F8FF            and ax,0xfff8
0000B125  8B167905          mov dx,[0x579]
0000B129  81E2F8FF          and dx,0xfff8
0000B12D  3BC2              cmp ax,dx
0000B12F  750C              jnz 0xb13d
0000B131  C606673901        mov byte [0x3967],0x1
0000B136  C6066E3901        mov byte [0x396e],0x1
0000B13B  EB18              jmp short 0xb155
0000B13D  A16439            mov ax,[0x3964]
0000B140  720A              jc 0xb14c
0000B142  2B06C639          sub ax,[0x39c6]
0000B146  7308              jnc 0xb150
0000B148  2BC0              sub ax,ax
0000B14A  EB04              jmp short 0xb150
0000B14C  0306C639          add ax,[0x39c6]
0000B150  A36439            mov [0x3964],ax
0000B153  EB54              jmp short 0xb1a9
0000B155  A06639            mov al,[0x3966]
0000B158  FE066E39          inc byte [0x396e]
0000B15C  8A166E39          mov dl,[0x396e]
0000B160  D0EA              shr dl,1
0000B162  D0EA              shr dl,1
0000B164  80E203            and dl,0x3
0000B167  80C202            add dl,0x2
0000B16A  803E673901        cmp byte [0x3967],0x1
0000B16F  7411              jz 0xb182
0000B171  2AC2              sub al,dl
0000B173  7204              jc 0xb179
0000B175  3C09              cmp al,0x9
0000B177  732D              jnc 0xb1a6
0000B179  B008              mov al,0x8
0000B17B  C606673900        mov byte [0x3967],0x0
0000B180  EB24              jmp short 0xb1a6
0000B182  02C2              add al,dl
0000B184  3A067B05          cmp al,[0x57b]
0000B188  7717              ja 0xb1a1
0000B18A  8B1E6439          mov bx,[0x3964]
0000B18E  2B1E7905          sub bx,[0x579]
0000B192  7302              jnc 0xb196
0000B194  F7D3              not bx
0000B196  83FB30            cmp bx,byte +0x30
0000B199  7706              ja 0xb1a1
0000B19B  3CA0              cmp al,0xa0
0000B19D  7207              jc 0xb1a6
0000B19F  B09F              mov al,0x9f
0000B1A1  C6066739FF        mov byte [0x3967],0xff
0000B1A6  A26639            mov [0x3966],al
0000B1A9  E8D600            call 0xb282
0000B1AC  730D              jnc 0xb1bb
0000B1AE  A1C339            mov ax,[0x39c3]
0000B1B1  A36439            mov [0x3964],ax
0000B1B4  A0C539            mov al,[0x39c5]
0000B1B7  A26639            mov [0x3966],al
0000B1BA  C3                ret
0000B1BB  E8E000            call 0xb29e
0000B1BE  735E              jnc 0xb21e
0000B1C0  803E530500        cmp byte [0x553],0x0
0000B1C5  7401              jz 0xb1c8
0000B1C7  C3                ret
0000B1C8  8B0E7905          mov cx,[0x579]
0000B1CC  83E90C            sub cx,byte +0xc
0000B1CF  7302              jnc 0xb1d3
0000B1D1  2BC9              sub cx,cx
0000B1D3  81F90F01          cmp cx,0x10f
0000B1D7  7203              jc 0xb1dc
0000B1D9  B90E01            mov cx,0x10e
0000B1DC  8A167B05          mov dl,[0x57b]
0000B1E0  80EA04            sub dl,0x4
0000B1E3  7302              jnc 0xb1e7
0000B1E5  2AD2              sub dl,dl
0000B1E7  E8F6EE            call 0xa0e0
0000B1EA  8BF8              mov di,ax
0000B1EC  B800B8            mov ax,0xb800
0000B1EF  8EC0              mov es,ax
0000B1F1  BEC037            mov si,0x37c0
0000B1F4  BD0E00            mov bp,0xe
0000B1F7  B90615            mov cx,0x1506
0000B1FA  E8FFEE            call 0xa0fc
0000B1FD  E82419            call 0xcb24
0000B200  2AE4              sub ah,ah
0000B202  CD1A              int 0x1a
0000B204  8916C839          mov [0x39c8],dx
0000B208  E82919            call 0xcb34
0000B20B  2AE4              sub ah,ah
0000B20D  CD1A              int 0x1a
0000B20F  2B16C839          sub dx,[0x39c8]
0000B213  83FA09            cmp dx,byte +0x9
0000B216  72F0              jc 0xb208
0000B218  C606520501        mov byte [0x552],0x1
0000B21D  C3                ret
0000B21E  8B0E6439          mov cx,[0x3964]
0000B222  8A166639          mov dl,[0x3966]
0000B226  E8B7EE            call 0xa0e0
0000B229  A3CA39            mov [0x39ca],ax
0000B22C  E83900            call 0xb268
0000B22F  FE0E6D39          dec byte [0x396d]
0000B233  750B              jnz 0xb240
0000B235  C6066D3902        mov byte [0x396d],0x2
0000B23A  81366B395400      xor word [0x396b],0x54
0000B240  E80100            call 0xb244
0000B243  C3                ret
0000B244  B800B8            mov ax,0xb800
0000B247  8EC0              mov es,ax
0000B249  8B3ECA39          mov di,[0x39ca]
0000B24D  893E6839          mov [0x3968],di
0000B251  BD6F39            mov bp,0x396f
0000B254  C6066A3900        mov byte [0x396a],0x0
0000B259  8B366B39          mov si,[0x396b]
0000B25D  81C6BC38          add si,0x38bc
0000B261  B9030E            mov cx,0xe03
0000B264  E895EE            call 0xa0fc
0000B267  C3                ret

0000B268  B800B8            mov ax,0xb800		; Draws the sprite.
0000B26B  8EC0              mov es,ax			;
0000B26D  803E6A3900        cmp byte [0x396a],0x0	;
0000B272  750D              jnz 0xb281			;
0000B274  8B3E6839          mov di,[0x3968]		;
0000B278  BE6F39            mov si,0x396f		;
0000B27B  B9030E            mov cx,0xe03		;
0000B27E  E84CEF            call 0xa1cd                	;
0000B281  C3                ret

0000B282  A16439            mov ax,[0x3964]
0000B285  8A166639          mov dl,[0x3966]
0000B289  BE1800            mov si,0x18
0000B28C  8B1E7D32          mov bx,[0x327d]
0000B290  8A367F32          mov dh,[0x327f]
0000B294  BF1000            mov di,0x10
0000B297  B90E1E            mov cx,0x1e0e
0000B29A  E8BCEF            call 0xa259
0000B29D  C3                ret
0000B29E  A16439            mov ax,[0x3964]
0000B2A1  8A166639          mov dl,[0x3966]
0000B2A5  BE1800            mov si,0x18
0000B2A8  8BFE              mov di,si
0000B2AA  8B1E7905          mov bx,[0x579]
0000B2AE  8A367B05          mov dh,[0x57b]
0000B2B2  B90E0E            mov cx,0xe0e
0000B2B5  E8A1EF            call 0xa259
0000B2B8  C3                ret
0000B2B9  0000              add [bx+si],al
0000B2BB  0000              add [bx+si],al
0000B2BD  0000              add [bx+si],al
0000B2BF  00803EE1          add [bx+si-0x1ec2],al
0000B2C3  3900              cmp [bx+si],ax
0000B2C5  740D              jz 0xb2d4
0000B2C7  2AE4              sub ah,ah
0000B2C9  CD1A              int 0x1a
0000B2CB  3B16163D          cmp dx,[0x3d16]
0000B2CF  7418              jz 0xb2e9
0000B2D1  E99100            jmp 0xb365
0000B2D4  803E840500        cmp byte [0x584],0x0
0000B2D9  750E              jnz 0xb2e9
0000B2DB  803E9A0600        cmp byte [0x69a],0x0
0000B2E0  7507              jnz 0xb2e9
0000B2E2  803EE03900        cmp byte [0x39e0],0x0
0000B2E7  7501              jnz 0xb2ea
0000B2E9  C3                ret
0000B2EA  E8A801            call 0xb495
0000B2ED  72FA              jc 0xb2e9
0000B2EF  2AE4              sub ah,ah
0000B2F1  CD1A              int 0x1a
0000B2F3  8BC2              mov ax,dx
0000B2F5  2B06183D          sub ax,[0x3d18]
0000B2F9  3D0C00            cmp ax,0xc
0000B2FC  72EB              jc 0xb2e9
0000B2FE  8916183D          mov [0x3d18],dx
0000B302  C6065C0500        mov byte [0x55c],0x0
0000B307  8A1EE039          mov bl,[0x39e0]
0000B30B  FECB              dec bl
0000B30D  2AFF              sub bh,bh
0000B30F  8BF3              mov si,bx
0000B311  B102              mov cl,0x2
0000B313  D3E6              shl si,cl
0000B315  8B845A3C          mov ax,[si+0x3c5a]
0000B319  A3E239            mov [0x39e2],ax
0000B31C  2BC0              sub ax,ax
0000B31E  80FB03            cmp bl,0x3
0000B321  7302              jnc 0xb325
0000B323  B080              mov al,0x80
0000B325  A3E439            mov [0x39e4],ax
0000B328  8A9FE33C          mov bl,[bx+0x3ce3]
0000B32C  8BF3              mov si,bx
0000B32E  B102              mov cl,0x2
0000B330  D3E6              shl si,cl
0000B332  8B845A3C          mov ax,[si+0x3c5a]
0000B336  A3E639            mov [0x39e6],ax
0000B339  2BC0              sub ax,ax
0000B33B  80FB03            cmp bl,0x3
0000B33E  7302              jnc 0xb342
0000B340  B080              mov al,0x80
0000B342  A3E839            mov [0x39e8],ax
0000B345  8A875010          mov al,[bx+0x1050]
0000B349  A2053D            mov [0x3d05],al
0000B34C  D0E3              shl bl,1
0000B34E  8B873711          mov ax,[bx+0x1137]
0000B352  050800            add ax,0x8
0000B355  A3033D            mov [0x3d03],ax
0000B358  E8B8D2            call 0x8613
0000B35B  C606E1390E        mov byte [0x39e1],0xe
0000B360  C6069A0610        mov byte [0x69a],0x10
0000B365  803EBF1C00        cmp byte [0x1cbf],0x0
0000B36A  7503              jnz 0xb36f
0000B36C  E861F4            call 0xa7d0
0000B36F  802EE13902        sub byte [0x39e1],0x2
0000B374  2AFF              sub bh,bh
0000B376  8A1EE139          mov bl,[0x39e1]
0000B37A  80FB08            cmp bl,0x8
0000B37D  7209              jc 0xb388
0000B37F  8B3EE239          mov di,[0x39e2]
0000B383  A1E439            mov ax,[0x39e4]
0000B386  EB18              jmp short 0xb3a0
0000B388  8B3EE639          mov di,[0x39e6]		; Draws the unknown sprite.
0000B38C  A0053D            mov al,[0x3d05]		;
0000B38F  A27B05            mov [0x57b],al		;
0000B392  0432              add al,0x32			;
0000B394  A27C05            mov [0x57c],al		;
0000B397  A1033D            mov ax,[0x3d03]		;
0000B39A  A37905            mov [0x579],ax		;
0000B39D  A1E839            mov ax,[0x39e8]		;
0000B3A0  0387063D          add ax,[bx+0x3d06]		;
0000B3A4  8BF0              mov si,ax			;
0000B3A6  B800B8            mov ax,0xb800		;
0000B3A9  8EC0              mov es,ax			;
0000B3AB  B90210            mov cx,0x1002		;
0000B3AE  E81CEE            call 0xa1cd			;
0000B3B1  803EBF1C00        cmp byte [0x1cbf],0x0
0000B3B6  7503              jnz 0xb3bb
0000B3B8  E8AEF3            call 0xa769
0000B3BB  2AE4              sub ah,ah
0000B3BD  CD1A              int 0x1a
0000B3BF  8916163D          mov [0x3d16],dx
0000B3C3  803EE13900        cmp byte [0x39e1],0x0
0000B3C8  7503              jnz 0xb3cd
0000B3CA  E875D1            call 0x8542
0000B3CD  C3                ret

0000B3CE  B800B8            mov ax,0xb800
0000B3D1  8EC0              mov es,ax
0000B3D3  C606E03900        mov byte [0x39e0],0x0
0000B3D8  C606E13900        mov byte [0x39e1],0x0
0000B3DD  C706BF3C0605      mov word [0x3cbf],0x506
0000B3E3  C706C13C0000      mov word [0x3cc1],0x0
0000B3E9  8B1EC13C          mov bx,[0x3cc1]
0000B3ED  8A8FAE3C          mov cl,[bx+0x3cae]
0000B3F1  2BDB              sub bx,bx
0000B3F3  8AEB              mov ch,bl
0000B3F5  BEEA3A            mov si,0x3aea
0000B3F8  E832EE            call 0xa22d        ; Get a random number.
0000B3FB  80FA30            cmp dl,0x30
0000B3FE  770B              ja 0xb40b
0000B400  BEF83A            mov si,0x3af8
0000B403  F6C204            test dl,0x4
0000B406  7503              jnz 0xb40b
0000B408  BE023B            mov si,0x3b02	; Draws the sprite.
0000B40B  8B3EBF3C          mov di,[0x3cbf]	;
0000B40F  03FB              add di,bx		;
0000B411  51                push cx		;
0000B412  53                push bx		;
0000B413  B90108            mov cx,0x801	;
0000B416  E8B4ED            call 0xa1cd         ;
0000B419  5B                pop bx
0000B41A  59                pop cx
0000B41B  83C302            add bx,byte +0x2
0000B41E  E2D5              loop 0xb3f5
0000B420  8106BF3C4001      add word [0x3cbf],0x140
0000B426  FF06C13C          inc word [0x3cc1]
0000B42A  833EC13C11        cmp word [0x3cc1],byte +0x11
0000B42F  72B8              jc 0xb3e9
0000B431  BB223C            mov bx,0x3c22
0000B434  2BC0              sub ax,ax
0000B436  E81BEB            call 0x9f54		; Call interleaved scanline renderer.
0000B439  BB3E3C            mov bx,0x3c3e
0000B43C  2BC0              sub ax,ax
0000B43E  E813EB            call 0x9f54 ; Call interleaved scanline renderer.
0000B441  BB9A3C            mov bx,0x3c9a
0000B444  2BC0              sub ax,ax
0000B446  E80BEB            call 0x9f54 ; Call interleaved scanline renderer.
0000B449  BB563C            mov bx,0x3c56
0000B44C  2BC0              sub ax,ax
0000B44E  E803EB            call 0x9f54 ; Call interleaved scanline renderer.
0000B451  BEAA3C            mov si,0x3caa
0000B454  BFEC08            mov di,0x8ec
0000B457  B90201            mov cx,0x102
0000B45A  BD0E00            mov bp,0xe
0000B45D  E805ED            call 0xa165
0000B460  2BF6              sub si,si
0000B462  8B1E0800          mov bx,[0x8]
0000B466  B103              mov cl,0x3
0000B468  22D9              and bl,cl
0000B46A  D2E3              shl bl,cl
0000B46C  8A87C33C          mov al,[bx+0x3cc3]
0000B470  8AE0              mov ah,al
0000B472  B104              mov cl,0x4
0000B474  D2E8              shr al,cl
0000B476  8884E33C          mov [si+0x3ce3],al
0000B47A  C684F33C00        mov byte [si+0x3cf3],0x0
0000B47F  80E40F            and ah,0xf
0000B482  88A4E43C          mov [si+0x3ce4],ah
0000B486  C684F43C00        mov byte [si+0x3cf4],0x0
0000B48B  83C602            add si,byte +0x2
0000B48E  43                inc bx
0000B48F  83FE10            cmp si,byte +0x10
0000B492  72D8              jc 0xb46c
0000B494  C3                ret
0000B495  A17D32            mov ax,[0x327d]
0000B498  8A167F32          mov dl,[0x327f]
0000B49C  BE1000            mov si,0x10
0000B49F  8B1E7905          mov bx,[0x579]
0000B4A3  8A367B05          mov dh,[0x57b]
0000B4A7  BF1800            mov di,0x18
0000B4AA  B91E0E            mov cx,0xe1e
0000B4AD  E8A9ED            call 0xa259
0000B4B0  C3                ret
0000B4B1  0000              add [bx+si],al
0000B4B3  0000              add [bx+si],al
0000B4B5  0000              add [bx+si],al
0000B4B7  0000              add [bx+si],al
0000B4B9  0000              add [bx+si],al
0000B4BB  0000              add [bx+si],al
0000B4BD  0000              add [bx+si],al
0000B4BF  00B90400          add [bx+di+0x4],bh
0000B4C3  8BD9              mov bx,cx
0000B4C5  4B                dec bx
0000B4C6  8BF3              mov si,bx
0000B4C8  D1E6              shl si,1
0000B4CA  C687AE3E01        mov byte [bx+0x3eae],0x1
0000B4CF  C687B23E00        mov byte [bx+0x3eb2],0x0
0000B4D4  E8D001            call 0xb6a7
0000B4D7  E853ED            call 0xa22d            ; Get a random number.
0000B4DA  80E20F            and dl,0xf
0000B4DD  80C214            add dl,0x14
0000B4E0  8897B63E          mov [bx+0x3eb6],dl
0000B4E4  E2DD              loop 0xb4c3
0000B4E6  C706DA3E0000      mov word [0x3eda],0x0
0000B4EC  C606D83E04        mov byte [0x3ed8],0x4
0000B4F1  C3                ret
0000B4F2  2AE4              sub ah,ah
0000B4F4  CD1A              int 0x1a
0000B4F6  3B16DC3E          cmp dx,[0x3edc]
0000B4FA  7501              jnz 0xb4fd
0000B4FC  C3                ret
0000B4FD  FF06DA3E          inc word [0x3eda]
0000B501  8B1EDA3E          mov bx,[0x3eda]
0000B505  83FB02            cmp bx,byte +0x2
0000B508  760B              jna 0xb515
0000B50A  83FB04            cmp bx,byte +0x4
0000B50D  720A              jc 0xb519
0000B50F  2BDB              sub bx,bx
0000B511  891EDA3E          mov [0x3eda],bx
0000B515  8916DC3E          mov [0x3edc],dx
0000B519  8BF3              mov si,bx
0000B51B  D1E6              shl si,1
0000B51D  80BFB23E00        cmp byte [bx+0x3eb2],0x0
0000B522  75D8              jnz 0xb4fc
0000B524  E8E401            call 0xb70b
0000B527  7303              jnc 0xb52c
0000B529  EB29              jmp short 0xb554
0000B52B  90                nop
0000B52C  E8FD01            call 0xb72c
0000B52F  72CB              jc 0xb4fc
0000B531  80BFB63E00        cmp byte [bx+0x3eb6],0x0
0000B536  7510              jnz 0xb548
0000B538  E86C01            call 0xb6a7
0000B53B  E8EFEC            call 0xa22d            ; Get a random number.
0000B53E  80E207            and dl,0x7
0000B541  80C214            add dl,0x14
0000B544  8897B63E          mov [bx+0x3eb6],dl
0000B548  FE8FB63E          dec byte [bx+0x3eb6]
0000B54C  E8BC01            call 0xb70b
0000B54F  7203              jc 0xb554
0000B551  EB5E              jmp short 0xb5b1
0000B553  90                nop
0000B554  80BFAE3E00        cmp byte [bx+0x3eae],0x0
0000B559  7507              jnz 0xb562
0000B55B  80BFB63E14        cmp byte [bx+0x3eb6],0x14
0000B560  7201              jc 0xb563
0000B562  C3                ret
0000B563  E8ADD0            call 0x8613
0000B566  E81B01            call 0xb684
0000B569  8B1EDA3E          mov bx,[0x3eda]
0000B56D  C687B23E01        mov byte [bx+0x3eb2],0x1
0000B572  E8DFCF            call 0x8554
0000B575  C6065C0500        mov byte [0x55c],0x0
0000B57A  FE0ED83E          dec byte [0x3ed8]
0000B57E  7505              jnz 0xb585
0000B580  C606530501        mov byte [0x553],0x1
0000B585  B004              mov al,0x4
0000B587  2A06D83E          sub al,[0x3ed8]
0000B58B  B102              mov cl,0x2
0000B58D  D2E0              shl al,cl
0000B58F  2AE4              sub ah,ah
0000B591  055100            add ax,0x51
0000B594  8BF8              mov di,ax
0000B596  BD0E00            mov bp,0xe
0000B599  BE203D            mov si,0x3d20
0000B59C  B800B8            mov ax,0xb800
0000B59F  8EC0              mov es,ax
0000B5A1  B9020C            mov cx,0xc02
0000B5A4  E8BEEB            call 0xa165
0000B5A7  B8E803            mov ax,0x3e8
0000B5AA  BBEE02            mov bx,0x2ee
0000B5AD  E8BB17            call 0xcd6b
0000B5B0  C3                ret
0000B5B1  E83001            call 0xb6e4
0000B5B4  8B3E0800          mov di,[0x8]
0000B5B8  D1E7              shl di,1
0000B5BA  8BADDE3E          mov bp,[di+0x3ede]
0000B5BE  E88B01            call 0xb74c
0000B5C1  731D              jnc 0xb5e0
0000B5C3  80BFB63E02        cmp byte [bx+0x3eb6],0x2
0000B5C8  7216              jc 0xb5e0
0000B5CA  B001              mov al,0x1
0000B5CC  80BFB63E11        cmp byte [bx+0x3eb6],0x11
0000B5D1  7609              jna 0xb5dc
0000B5D3  80BFB63E14        cmp byte [bx+0x3eb6],0x14
0000B5D8  7306              jnc 0xb5e0
0000B5DA  FEC8              dec al
0000B5DC  8887B63E          mov [bx+0x3eb6],al
0000B5E0  8A87B63E          mov al,[bx+0x3eb6]
0000B5E4  3C01              cmp al,0x1
0000B5E6  7620              jna 0xb608
0000B5E8  3C12              cmp al,0x12
0000B5EA  723C              jc 0xb628
0000B5EC  B001              mov al,0x1
0000B5EE  83BCBA3E03        cmp word [si+0x3eba],byte +0x3
0000B5F3  7302              jnc 0xb5f7
0000B5F5  B003              mov al,0x3
0000B5F7  0087D43E          add [bx+0x3ed4],al
0000B5FB  80BFB63E13        cmp byte [bx+0x3eb6],0x13
0000B600  7221              jc 0xb623
0000B602  741A              jz 0xb61e
0000B604  2BC0              sub ax,ax
0000B606  EB2C              jmp short 0xb634
0000B608  B001              mov al,0x1
0000B60A  83BCBA3E03        cmp word [si+0x3eba],byte +0x3
0000B60F  7302              jnc 0xb613
0000B611  B003              mov al,0x3
0000B613  0087D43E          add [bx+0x3ed4],al
0000B617  80BFB63E01        cmp byte [bx+0x3eb6],0x1
0000B61C  7305              jnc 0xb623
0000B61E  B8B03D            mov ax,0x3db0
0000B621  EB11              jmp short 0xb634
0000B623  B8803D            mov ax,0x3d80
0000B626  EB0C              jmp short 0xb634
0000B628  D0E0              shl al,1
0000B62A  8BF8              mov di,ax
0000B62C  81E70200          and di,0x2
0000B630  8B85E03D          mov ax,[di+0x3de0]
0000B634  A3CA3E            mov [0x3eca],ax
0000B637  8A97D43E          mov dl,[bx+0x3ed4]
0000B63B  8B8CCC3E          mov cx,[si+0x3ecc]
0000B63F  E89EEA            call 0xa0e0
0000B642  A3E43D            mov [0x3de4],ax
0000B645  E83C00            call 0xb684
0000B648  8B1EDA3E          mov bx,[0x3eda]
0000B64C  8BF3              mov si,bx
0000B64E  D1E6              shl si,1
0000B650  E8D900            call 0xb72c
0000B653  7301              jnc 0xb656
0000B655  C3                ret
0000B656  833ECA3E00        cmp word [0x3eca],byte +0x0
0000B65B  7506              jnz 0xb663
0000B65D  C687AE3E01        mov byte [bx+0x3eae],0x1
0000B662  C3                ret
0000B663  C687AE3E00        mov byte [bx+0x3eae],0x0
0000B668  8B3EE43D          mov di,[0x3de4]
0000B66C  89BCA63E          mov [si+0x3ea6],di
0000B670  B800B8            mov ax,0xb800
0000B673  8EC0              mov es,ax
0000B675  8BACC23E          mov bp,[si+0x3ec2]
0000B679  B9020C            mov cx,0xc02
0000B67C  8B36CA3E          mov si,[0x3eca]
0000B680  E8E2EA            call 0xa165
0000B683  C3                ret
0000B684  8B1EDA3E          mov bx,[0x3eda]
0000B688  8BF3              mov si,bx
0000B68A  D1E6              shl si,1
0000B68C  80BFAE3E00        cmp byte [bx+0x3eae],0x0
0000B691  7513              jnz 0xb6a6
0000B693  8BBCA63E          mov di,[si+0x3ea6]			; Draws the unknown sprite.
0000B697  B9020C            mov cx,0xc02			;
0000B69A  8BB4C23E          mov si,[si+0x3ec2]			;
0000B69E  B800B8            mov ax,0xb800			;
0000B6A1  8EC0              mov es,ax				;
0000B6A3  E827EB            call 0xa1cd				;
0000B6A6  C3                ret

0000B6A7  C606D93E20        mov byte [0x3ed9],0x20
0000B6AC  E87EEB            call 0xa22d            ; Get a random number.
0000B6AF  81E20F00          and dx,0xf
0000B6B3  2BFF              sub di,di
0000B6B5  3BFE              cmp di,si
0000B6B7  7406              jz 0xb6bf
0000B6B9  3B95BA3E          cmp dx,[di+0x3eba]
0000B6BD  74ED              jz 0xb6ac
0000B6BF  83C702            add di,byte +0x2
0000B6C2  83FF08            cmp di,byte +0x8
0000B6C5  72EE              jc 0xb6b5
0000B6C7  8994BA3E          mov [si+0x3eba],dx
0000B6CB  E81600            call 0xb6e4
0000B6CE  803ED93E00        cmp byte [0x3ed9],0x0
0000B6D3  740E              jz 0xb6e3
0000B6D5  BD3200            mov bp,0x32
0000B6D8  E87100            call 0xb74c
0000B6DB  7306              jnc 0xb6e3
0000B6DD  FE0ED93E          dec byte [0x3ed9]
0000B6E1  EBC9              jmp short 0xb6ac
0000B6E3  C3                ret
0000B6E4  8BBCBA3E          mov di,[si+0x3eba]
0000B6E8  8A855010          mov al,[di+0x1050]
0000B6EC  B20A              mov dl,0xa
0000B6EE  83FF03            cmp di,byte +0x3
0000B6F1  7302              jnc 0xb6f5
0000B6F3  2AD2              sub dl,dl
0000B6F5  2AC2              sub al,dl
0000B6F7  0403              add al,0x3
0000B6F9  8887D43E          mov [bx+0x3ed4],al
0000B6FD  D1E7              shl di,1
0000B6FF  8B853711          mov ax,[di+0x1137]
0000B703  050800            add ax,0x8
0000B706  8984CC3E          mov [si+0x3ecc],ax
0000B70A  C3                ret
0000B70B  56                push si
0000B70C  53                push bx
0000B70D  8B84CC3E          mov ax,[si+0x3ecc]
0000B711  8A97D43E          mov dl,[bx+0x3ed4]
0000B715  BE1000            mov si,0x10
0000B718  8B1E7905          mov bx,[0x579]
0000B71C  8A367B05          mov dh,[0x57b]
0000B720  BF1800            mov di,0x18
0000B723  B90C0E            mov cx,0xe0c
0000B726  E830EB            call 0xa259
0000B729  5B                pop bx
0000B72A  5E                pop si
0000B72B  C3                ret
0000B72C  56                push si
0000B72D  53                push bx
0000B72E  8B84CC3E          mov ax,[si+0x3ecc]
0000B732  8A97D43E          mov dl,[bx+0x3ed4]
0000B736  BE1000            mov si,0x10
0000B739  8B1E7D32          mov bx,[0x327d]
0000B73D  8A367F32          mov dh,[0x327f]
0000B741  8BFE              mov di,si
0000B743  B90C1E            mov cx,0x1e0c
0000B746  E810EB            call 0xa259
0000B749  5B                pop bx
0000B74A  5E                pop si
0000B74B  C3                ret
0000B74C  8B84CC3E          mov ax,[si+0x3ecc]
0000B750  2B067905          sub ax,[0x579]
0000B754  7302              jnc 0xb758
0000B756  F7D0              not ax
0000B758  8A97D43E          mov dl,[bx+0x3ed4]
0000B75C  2A167B05          sub dl,[0x57b]
0000B760  7302              jnc 0xb764
0000B762  F6D2              not dl
0000B764  2AF6              sub dh,dh
0000B766  03C2              add ax,dx
0000B768  3BC5              cmp ax,bp
0000B76A  7202              jc 0xb76e
0000B76C  F8                clc
0000B76D  C3                ret
0000B76E  F9                stc
0000B76F  C3                ret
0000B770  2AE4              sub ah,ah
0000B772  CD1A              int 0x1a
0000B774  3B16B540          cmp dx,[0x40b5]
0000B778  7501              jnz 0xb77b
0000B77A  C3                ret
0000B77B  FE06FF40          inc byte [0x40ff]
0000B77F  F606FF4003        test byte [0x40ff],0x3
0000B784  7404              jz 0xb78a
0000B786  8916B540          mov [0x40b5],dx
0000B78A  803EAA40A4        cmp byte [0x40aa],0xa4
0000B78F  72E9              jc 0xb77a
0000B791  E8C901            call 0xb95d
0000B794  E8F001            call 0xb987
0000B797  72E1              jc 0xb77a
0000B799  E891EA            call 0xa22d            ; Get a random number.
0000B79C  80FA30            cmp dl,0x30
0000B79F  772B              ja 0xb7cc
0000B7A1  E88701            call 0xb92b
0000B7A4  8B360800          mov si,[0x8]
0000B7A8  D1E6              shl si,1
0000B7AA  8B84CE40          mov ax,[si+0x40ce]
0000B7AE  3906CC40          cmp [0x40cc],ax
0000B7B2  7718              ja 0xb7cc
0000B7B4  E8D615            call 0xcd8d
0000B7B7  C706C840FF00      mov word [0x40c8],0xff
0000B7BD  A0CA40            mov al,[0x40ca]
0000B7C0  A2B740            mov [0x40b7],al
0000B7C3  A0CB40            mov al,[0x40cb]
0000B7C6  A2B840            mov [0x40b8],al
0000B7C9  E99200            jmp 0xb85e
0000B7CC  833EC8400A        cmp word [0x40c8],byte +0xa
0000B7D1  770E              ja 0xb7e1
0000B7D3  E857EA            call 0xa22d            ; Get a random number.
0000B7D6  80FA06            cmp dl,0x6
0000B7D9  7709              ja 0xb7e4
0000B7DB  C706C840FF00      mov word [0x40c8],0xff
0000B7E1  EB4F              jmp short 0xb832
0000B7E3  90                nop
0000B7E4  8B1EC840          mov bx,[0x40c8]
0000B7E8  8BF3              mov si,bx
0000B7EA  D1E6              shl si,1
0000B7EC  2AD2              sub dl,dl
0000B7EE  A1B240            mov ax,[0x40b2]
0000B7F1  25FC0F            and ax,0xffc
0000B7F4  3B84DE40          cmp ax,[si+0x40de]
0000B7F8  7406              jz 0xb800
0000B7FA  FEC2              inc dl
0000B7FC  7202              jc 0xb800
0000B7FE  B2FF              mov dl,0xff
0000B800  8816B740          mov [0x40b7],dl
0000B804  2AD2              sub dl,dl
0000B806  A0B440            mov al,[0x40b4]
0000B809  24FE              and al,0xfe
0000B80B  3A87F440          cmp al,[bx+0x40f4]
0000B80F  7406              jz 0xb817
0000B811  FEC2              inc dl
0000B813  7202              jc 0xb817
0000B815  B2FF              mov dl,0xff
0000B817  8816B840          mov [0x40b8],dl
0000B81B  0A16B740          or dl,[0x40b7]
0000B81F  753D              jnz 0xb85e
0000B821  E809EA            call 0xa22d            ; Get a random number.
0000B824  80FA10            cmp dl,0x10
0000B827  7735              ja 0xb85e
0000B829  C706C840FF00      mov word [0x40c8],0xff
0000B82F  E85B15            call 0xcd8d
0000B832  E8F8E9            call 0xa22d            ; Get a random number.
0000B835  80FA30            cmp dl,0x30
0000B838  7719              ja 0xb853
0000B83A  80E201            and dl,0x1
0000B83D  7502              jnz 0xb841
0000B83F  B2FF              mov dl,0xff
0000B841  8816B740          mov [0x40b7],dl
0000B845  E8E5E9            call 0xa22d            ; Get a random number.
0000B848  80E201            and dl,0x1
0000B84B  7502              jnz 0xb84f
0000B84D  B2FF              mov dl,0xff
0000B84F  8816B840          mov [0x40b8],dl
0000B853  E8D7E9            call 0xa22d            ; Get a random number.
0000B856  81E2FF00          and dx,0xff
0000B85A  8916C840          mov [0x40c8],dx
0000B85E  A0B440            mov al,[0x40b4]
0000B861  803EB84001        cmp byte [0x40b8],0x1
0000B866  7221              jc 0xb889
0000B868  750F              jnz 0xb879
0000B86A  0402              add al,0x2
0000B86C  3CA8              cmp al,0xa8
0000B86E  7216              jc 0xb886
0000B870  B0A7              mov al,0xa7
0000B872  C606B840FF        mov byte [0x40b8],0xff
0000B877  EB0D              jmp short 0xb886
0000B879  2C02              sub al,0x2
0000B87B  3C30              cmp al,0x30
0000B87D  7307              jnc 0xb886
0000B87F  B030              mov al,0x30
0000B881  C606B84001        mov byte [0x40b8],0x1
0000B886  A2B440            mov [0x40b4],al
0000B889  A1B240            mov ax,[0x40b2]
0000B88C  803EB74001        cmp byte [0x40b7],0x1
0000B891  7223              jc 0xb8b6
0000B893  7512              jnz 0xb8a7
0000B895  050400            add ax,0x4
0000B898  3D3601            cmp ax,0x136
0000B89B  7216              jc 0xb8b3
0000B89D  B83501            mov ax,0x135
0000B8A0  C606B740FF        mov byte [0x40b7],0xff
0000B8A5  EB0C              jmp short 0xb8b3
0000B8A7  2D0400            sub ax,0x4
0000B8AA  7307              jnc 0xb8b3
0000B8AC  2BC0              sub ax,ax
0000B8AE  C606B74001        mov byte [0x40b7],0x1
0000B8B3  A3B240            mov [0x40b2],ax
0000B8B6  E8A400            call 0xb95d
0000B8B9  8B0EB240          mov cx,[0x40b2]
0000B8BD  8A16B440          mov dl,[0x40b4]
0000B8C1  E81CE8            call 0xa0e0
0000B8C4  A3BC40            mov [0x40bc],ax		
0000B8C7  B800B8            mov ax,0xb800		
0000B8CA  8EC0              mov es,ax			
0000B8CC  803EB94000        cmp byte [0x40b9],0x0	
0000B8D1  750D              jnz 0xb8e0			
0000B8D3  BE2C3F            mov si,0x3f2c		; Draws the sprite.
0000B8D6  8B3EBA40          mov di,[0x40ba]		;
0000B8DA  B90105            mov cx,0x501		;
0000B8DD  E8EDE8            call 0xa1cd                 ;
0000B8E0  E8A400            call 0xb987
0000B8E3  7231              jc 0xb916
0000B8E5  C606B94000        mov byte [0x40b9],0x0
0000B8EA  8306BE4002        add word [0x40be],byte +0x2
0000B8EF  8B1EBE40          mov bx,[0x40be]
0000B8F3  81E30600          and bx,0x6
0000B8F7  8BB7C040          mov si,[bx+0x40c0]
0000B8FB  803EB740FF        cmp byte [0x40b7],0xff
0000B900  7503              jnz 0xb905
0000B902  83C61E            add si,byte +0x1e
0000B905  8B3EBC40          mov di,[0x40bc]
0000B909  893EBA40          mov [0x40ba],di
0000B90D  BD2C3F            mov bp,0x3f2c
0000B910  B90105            mov cx,0x501
0000B913  E8E6E7            call 0xa0fc
0000B916  C3                ret
0000B917  803E710500        cmp byte [0x571],0x0
0000B91C  750B              jnz 0xb929
0000B91E  A07B05            mov al,[0x57b]
0000B921  24F8              and al,0xf8
0000B923  3C88              cmp al,0x88
0000B925  7502              jnz 0xb929
0000B927  F9                stc
0000B928  C3                ret
0000B929  F8                clc
0000B92A  C3                ret
0000B92B  A1B240            mov ax,[0x40b2]
0000B92E  B201              mov dl,0x1
0000B930  2B067905          sub ax,[0x579]
0000B934  7304              jnc 0xb93a
0000B936  F7D0              not ax
0000B938  B2FF              mov dl,0xff
0000B93A  8816CA40          mov [0x40ca],dl
0000B93E  A3CC40            mov [0x40cc],ax
0000B941  A0B440            mov al,[0x40b4]
0000B944  B201              mov dl,0x1
0000B946  2A067B05          sub al,[0x57b]
0000B94A  7304              jnc 0xb950
0000B94C  F6D0              not al
0000B94E  B2FF              mov dl,0xff
0000B950  8816CB40          mov [0x40cb],dl
0000B954  2AE4              sub ah,ah
0000B956  D1E0              shl ax,1
0000B958  0106CC40          add [0x40cc],ax
0000B95C  C3                ret
0000B95D  A1B240            mov ax,[0x40b2]
0000B960  8A16B440          mov dl,[0x40b4]
0000B964  BE0800            mov si,0x8
0000B967  8B1E7905          mov bx,[0x579]
0000B96B  8A367B05          mov dh,[0x57b]
0000B96F  BF1800            mov di,0x18
0000B972  B9050E            mov cx,0xe05
0000B975  E8E1E8            call 0xa259
0000B978  730C              jnc 0xb986
0000B97A  803E520500        cmp byte [0x552],0x0
0000B97F  7505              jnz 0xb986
0000B981  C606530501        mov byte [0x553],0x1
0000B986  C3                ret
0000B987  A1B240            mov ax,[0x40b2]
0000B98A  8A16B440          mov dl,[0x40b4]
0000B98E  BE0800            mov si,0x8
0000B991  8B1E7D32          mov bx,[0x327d]
0000B995  8A367F32          mov dh,[0x327f]
0000B999  BF1000            mov di,0x10
0000B99C  B9051E            mov cx,0x1e05
0000B99F  E8B7E8            call 0xa259
0000B9A2  7305              jnc 0xb9a9
0000B9A4  C606B840FF        mov byte [0x40b8],0xff
0000B9A9  C3                ret
0000B9AA  B99000            mov cx,0x90
0000B9AD  B286              mov dl,0x86
0000B9AF  890EA840          mov [0x40a8],cx
0000B9B3  8816AA40          mov [0x40aa],dl
0000B9B7  E826E7            call 0xa0e0
0000B9BA  A3AB40            mov [0x40ab],ax
0000B9BD  E8C901            call 0xbb89
0000B9C0  C606AF4000        mov byte [0x40af],0x0
0000B9C5  C606B14000        mov byte [0x40b1],0x0
0000B9CA  C606B94001        mov byte [0x40b9],0x1
0000B9CF  C606B84000        mov byte [0x40b8],0x0
0000B9D4  C706C840FF00      mov word [0x40c8],0xff
0000B9DA  C3                ret
0000B9DB  2AE4              sub ah,ah
0000B9DD  CD1A              int 0x1a
0000B9DF  3B16AD40          cmp dx,[0x40ad]
0000B9E3  7501              jnz 0xb9e6
0000B9E5  C3                ret
0000B9E6  8916AD40          mov [0x40ad],dx
0000B9EA  803EAA40A4        cmp byte [0x40aa],0xa4
0000B9EF  73F4              jnc 0xb9e5
0000B9F1  E8C201            call 0xbbb6
0000B9F4  7310              jnc 0xba06
0000B9F6  E81EFF            call 0xb917
0000B9F9  73EA              jnc 0xb9e5
0000B9FB  C606710501        mov byte [0x571],0x1
0000BA00  C6065B0510        mov byte [0x55b],0x10
0000BA05  C3                ret

0000BA06  E86501            call 0xbb6e
0000BA09  736E              jnc 0xba79
0000BA0B  803EAF4000        cmp byte [0x40af],0x0
0000BA10  7518              jnz 0xba2a
0000BA12  A06E05            mov al,[0x56e]
0000BA15  3C00              cmp al,0x0
0000BA17  750E              jnz 0xba27
0000BA19  FEC0              inc al
0000BA1B  8B1EA840          mov bx,[0x40a8]
0000BA1F  3B1E7905          cmp bx,[0x579]
0000BA23  7702              ja 0xba27
0000BA25  B0FF              mov al,0xff
0000BA27  A2B040            mov [0x40b0],al
0000BA2A  C606AF4001        mov byte [0x40af],0x1
0000BA2F  B92000            mov cx,0x20
0000BA32  A17905            mov ax,[0x579]
0000BA35  B201              mov dl,0x1
0000BA37  803EB04001        cmp byte [0x40b0],0x1
0000BA3C  7507              jnz 0xba45
0000BA3E  2D0800            sub ax,0x8
0000BA41  B2FF              mov dl,0xff
0000BA43  EB03              jmp short 0xba48
0000BA45  050800            add ax,0x8
0000BA48  A37905            mov [0x579],ax
0000BA4B  88166E05          mov [0x56e],dl
0000BA4F  A07B05            mov al,[0x57b]
0000BA52  803E710501        cmp byte [0x571],0x1
0000BA57  7210              jc 0xba69
0000BA59  7504              jnz 0xba5f
0000BA5B  2C03              sub al,0x3
0000BA5D  EB02              jmp short 0xba61
0000BA5F  0403              add al,0x3
0000BA61  A27B05            mov [0x57b],al
0000BA64  0432              add al,0x32
0000BA66  A27C05            mov [0x57c],al
0000BA69  51                push cx
0000BA6A  E80101            call 0xbb6e
0000BA6D  59                pop cx
0000BA6E  7302              jnc 0xba72
0000BA70  E2C0              loop 0xba32
0000BA72  E89ECB            call 0x8613
0000BA75  E8CACA            call 0x8542
0000BA78  C3                ret

0000BA79  803EB14000        cmp byte [0x40b1],0x0
0000BA7E  7552              jnz 0xbad2
0000BA80  803EAF4000        cmp byte [0x40af],0x0
0000BA85  74F1              jz 0xba78
0000BA87  A1A840            mov ax,[0x40a8]
0000BA8A  803EB04001        cmp byte [0x40b0],0x1
0000BA8F  7505              jnz 0xba96
0000BA91  050800            add ax,0x8
0000BA94  EB03              jmp short 0xba99
0000BA96  2D0800            sub ax,0x8
0000BA99  A3A840            mov [0x40a8],ax
0000BA9C  E8CF00            call 0xbb6e
0000BA9F  7301              jnc 0xbaa2
0000BAA1  C3                ret

0000BAA2  B8000C            mov ax,0xc00
0000BAA5  BB540B            mov bx,0xb54
0000BAA8  E8C012            call 0xcd6b
0000BAAB  C606AF4000        mov byte [0x40af],0x0
0000BAB0  8B0EA840          mov cx,[0x40a8]
0000BAB4  8A16AA40          mov dl,[0x40aa]
0000BAB8  E825E6            call 0xa0e0
0000BABB  A3AB40            mov [0x40ab],ax
0000BABE  E8E200            call 0xbba3
0000BAC1  E8C500            call 0xbb89
0000BAC4  A1A840            mov ax,[0x40a8]
0000BAC7  3D7800            cmp ax,0x78
0000BACA  7206              jc 0xbad2
0000BACC  3DA800            cmp ax,0xa8
0000BACF  7701              ja 0xbad2
0000BAD1  C3                ret

0000BAD2  C606B14001        mov byte [0x40b1],0x1
0000BAD7  803EBF1C00        cmp byte [0x1cbf],0x0
0000BADC  7410              jz 0xbaee
0000BADE  E836FE            call 0xb917
0000BAE1  730A              jnc 0xbaed
0000BAE3  C606710501        mov byte [0x571],0x1
0000BAE8  C6065B0510        mov byte [0x55b],0x10
0000BAED  C3                ret

0000BAEE  2AE4              sub ah,ah
0000BAF0  CD1A              int 0x1a
0000BAF2  3B16AD40          cmp dx,[0x40ad]
0000BAF6  74DA              jz 0xbad2
0000BAF8  8916AD40          mov [0x40ad],dx
0000BAFC  803E000000        cmp byte [0x0],0x0
0000BB01  7419              jz 0xbb1c
0000BB03  B0B6              mov al,0xb6		; Set the frequency.
0000BB05  E643              out 0x43,al		;
0000BB07  A0AA40            mov al,[0x40aa]	;
0000BB0A  2AE4              sub ah,ah		;
0000BB0C  D1E0              shl ax,1		;
0000BB0E  D1E0              shl ax,1		;
0000BB10  E642              out 0x42,al		;
0000BB12  8AC4              mov al,ah		;
0000BB14  E642              out 0x42,al		;
0000BB16  E461              in al,0x61		; Turn on the PC-Speaker.
0000BB18  0C03              or al,0x3		;
0000BB1A  E661              out 0x61,al         ;
0000BB1C  8A16AA40          mov dl,[0x40aa]
0000BB20  80FAA4            cmp dl,0xa4
0000BB23  7319              jnc 0xbb3e
0000BB25  80C205            add dl,0x5
0000BB28  8816AA40          mov [0x40aa],dl
0000BB2C  8B0EA840          mov cx,[0x40a8]
0000BB30  E8ADE5            call 0xa0e0
0000BB33  A3AB40            mov [0x40ab],ax
0000BB36  E86A00            call 0xbba3
0000BB39  E84D00            call 0xbb89
0000BB3C  EBB0              jmp short 0xbaee
0000BB3E  E81014            call 0xcf51		; Turn off the PC-Speaker.
0000BB41  E85F00            call 0xbba3
0000BB44  BD1E40            mov bp,0x401e
0000BB47  FF0EA640          dec word [0x40a6]
0000BB4B  8B3EA640          mov di,[0x40a6]
0000BB4F  BE363F            mov si,0x3f36
0000BB52  B90411            mov cx,0x1104
0000BB55  E80DE6            call 0xa165
0000BB58  A1A840            mov ax,[0x40a8]
0000BB5B  A3B240            mov [0x40b2],ax
0000BB5E  A0AA40            mov al,[0x40aa]
0000BB61  A2B440            mov [0x40b4],al
0000BB64  E8C4FD            call 0xb92b
0000BB67  A0CA40            mov al,[0x40ca]
0000BB6A  A2B740            mov [0x40b7],al
0000BB6D  C3                ret

0000BB6E  A1A840            mov ax,[0x40a8]
0000BB71  8A16AA40          mov dl,[0x40aa]
0000BB75  BE1800            mov si,0x18
0000BB78  8B1E7905          mov bx,[0x579]
0000BB7C  8A367B05          mov dh,[0x57b]
0000BB80  8BFE              mov di,si
0000BB82  B9100E            mov cx,0xe10
0000BB85  E8D1E6            call 0xa259
0000BB88  C3                ret

0000BB89  B800B8            mov ax,0xb800     ; Video memory.
0000BB8C  8EC0              mov es,ax         ;
0000BB8E  BD1E40            mov bp,0x401e
0000BB91  BEBE3F            mov si,0x3fbe
0000BB94  8B3EAB40          mov di,[0x40ab]
0000BB98  893EA640          mov [0x40a6],di
0000BB9C  B90310            mov cx,0x1003
0000BB9F  E8C3E5            call 0xa165
0000BBA2  C3                ret

0000BBA3  B800B8            mov ax,0xb800 	; Draws the sprite.
0000BBA6  8EC0              mov es,ax     	;
0000BBA8  BE1E40            mov si,0x401e	;
0000BBAB  8B3EA640          mov di,[0x40a6]	;
0000BBAF  B90310            mov cx,0x1003	;
0000BBB2  E818E6            call 0xa1cd  	;
0000BBB5  C3                ret

0000BBB6  803E7F3266        cmp byte [0x327f],0x66
0000BBBB  7217              jc 0xbbd4
0000BBBD  A1A840            mov ax,[0x40a8]
0000BBC0  2D1400            sub ax,0x14
0000BBC3  3B067D32          cmp ax,[0x327d]
0000BBC7  770B              ja 0xbbd4
0000BBC9  053000            add ax,0x30
0000BBCC  3B067D32          cmp ax,[0x327d]
0000BBD0  7202              jc 0xbbd4
0000BBD2  F9                stc
0000BBD3  C3                ret
0000BBD4  F8                clc
0000BBD5  C3                ret
0000BBD6  0000              add [bx+si],al
0000BBD8  0000              add [bx+si],al
0000BBDA  0000              add [bx+si],al
0000BBDC  0000              add [bx+si],al
0000BBDE  0000              add [bx+si],al
0000BBE0  A17D32            mov ax,[0x327d]
0000BBE3  8A167F32          mov dl,[0x327f]
0000BBE7  BE1000            mov si,0x10
0000BBEA  8B1E7905          mov bx,[0x579]
0000BBEE  83EB08            sub bx,byte +0x8
0000BBF1  7302              jnc 0xbbf5
0000BBF3  2BDB              sub bx,bx
0000BBF5  8A367B05          mov dh,[0x57b]
0000BBF9  80C603            add dh,0x3
0000BBFC  BF2800            mov di,0x28
0000BBFF  B91E0E            mov cx,0xe1e
0000BC02  E854E6            call 0xa259
0000BC05  C3                ret
0000BC06  2AE4              sub ah,ah
0000BC08  CD1A              int 0x1a
0000BC0A  8BC2              mov ax,dx
0000BC0C  2B06D744          sub ax,[0x44d7]
0000BC10  8B360800          mov si,[0x8]
0000BC14  D1E6              shl si,1
0000BC16  3B84DC44          cmp ax,[si+0x44dc]
0000BC1A  7701              ja 0xbc1d
0000BC1C  C3                ret
0000BC1D  8916D744          mov [0x44d7],dx
0000BC21  803EB81C00        cmp byte [0x1cb8],0x0
0000BC26  75F4              jnz 0xbc1c
0000BC28  C606FC4400        mov byte [0x44fc],0x0
0000BC2D  B90C00            mov cx,0xc
0000BC30  8BD9              mov bx,cx
0000BC32  4B                dec bx
0000BC33  D0E3              shl bl,1
0000BC35  83BF414400        cmp word [bx+0x4441],byte +0x0
0000BC3A  7471              jz 0xbcad
0000BC3C  8B87F943          mov ax,[bx+0x43f9]
0000BC40  3A067B05          cmp al,[0x57b]
0000BC44  7547              jnz 0xbc8d
0000BC46  8B87E143          mov ax,[bx+0x43e1]
0000BC4A  2B067905          sub ax,[0x579]
0000BC4E  7302              jnc 0xbc52
0000BC50  F7D0              not ax
0000BC52  8B360800          mov si,[0x8]
0000BC56  D1E6              shl si,1
0000BC58  3B84EC44          cmp ax,[si+0x44ec]
0000BC5C  772F              ja 0xbc8d
0000BC5E  83BF594402        cmp word [bx+0x4459],byte +0x2
0000BC63  7217              jc 0xbc7c
0000BC65  8B871144          mov ax,[bx+0x4411]
0000BC69  A3DA44            mov [0x44da],ax
0000BC6C  E84E00            call 0xbcbd
0000BC6F  E85F00            call 0xbcd1
0000BC72  E8F4EA            call 0xa769
0000BC75  E8FDC8            call 0x8575
0000BC78  E8EBD8            call 0x9566
0000BC7B  C3                ret
0000BC7C  FF875944          inc word [bx+0x4459]
0000BC80  83BF594402        cmp word [bx+0x4459],byte +0x2
0000BC85  7219              jc 0xbca0
0000BC87  FE06FC44          inc byte [0x44fc]
0000BC8B  EB13              jmp short 0xbca0
0000BC8D  83BF594400        cmp word [bx+0x4459],byte +0x0
0000BC92  7419              jz 0xbcad
0000BC94  E896E5            call 0xa22d            ; Get a random number.
0000BC97  80FA38            cmp dl,0x38
0000BC9A  7704              ja 0xbca0
0000BC9C  FF8F5944          dec word [bx+0x4459]
0000BCA0  51                push cx
0000BCA1  53                push bx
0000BCA2  E86200            call 0xbd07
0000BCA5  5B                pop bx
0000BCA6  E89D00            call 0xbd46
0000BCA9  E84500            call 0xbcf1
0000BCAC  59                pop cx
0000BCAD  E20B              loop 0xbcba
0000BCAF  803EFC4400        cmp byte [0x44fc],0x0
0000BCB4  7403              jz 0xbcb9
0000BCB6  E8080E            call 0xcac1
0000BCB9  C3                ret
0000BCBA  E973FF            jmp 0xbc30
0000BCBD  803EBD4400        cmp byte [0x44bd],0x0
0000BCC2  7409              jz 0xbccd
0000BCC4  E86C02            call 0xbf33
0000BCC7  C606BD4400        mov byte [0x44bd],0x0
0000BCCC  C3                ret
0000BCCD  E843C9            call 0x8613
0000BCD0  C3                ret
0000BCD1  1E                push ds
0000BCD2  07                pop es
0000BCD3  FC                cld
0000BCD4  BF0E00            mov di,0xe		
0000BCD7  8BF7              mov si,di		
0000BCD9  B8AAAA            mov ax,0xaaaa	
0000BCDC  B94100            mov cx,0x41		
0000BCDF  F3AB              rep stosw		
0000BCE1  B800B8            mov ax,0xb800	; Draws the sprite.
0000BCE4  8EC0              mov es,ax		;
0000BCE6  8B3EDA44          mov di,[0x44da]	;
0000BCEA  B9050D            mov cx,0xd05	;
0000BCED  E8DDE4            call 0xa1cd		;
0000BCF0  C3                ret

0000BCF1  803ED94400        cmp byte [0x44d9],0x0
0000BCF6  740A              jz 0xbd02
0000BCF8  803EBD4400        cmp byte [0x44bd],0x0
0000BCFD  7404              jz 0xbd03
0000BCFF  E84B02            call 0xbf4d
0000BD02  C3                ret
0000BD03  E86FC8            call 0x8575
0000BD06  C3                ret
0000BD07  C606D94400        mov byte [0x44d9],0x0
0000BD0C  8B87E143          mov ax,[bx+0x43e1]
0000BD10  8B97F943          mov dx,[bx+0x43f9]
0000BD14  2D1400            sub ax,0x14
0000BD17  BE2800            mov si,0x28
0000BD1A  8B1E7905          mov bx,[0x579]
0000BD1E  8A367B05          mov dh,[0x57b]
0000BD22  B9060E            mov cx,0xe06
0000BD25  BF1800            mov di,0x18
0000BD28  E82EE5            call 0xa259
0000BD2B  7318              jnc 0xbd45
0000BD2D  C606D94401        mov byte [0x44d9],0x1
0000BD32  E8D3CA            call 0x8808   ; Get vertical retrace status.
0000BD35  74FB              jz 0xbd32
0000BD37  803EBD4400        cmp byte [0x44bd],0x0
0000BD3C  7404              jz 0xbd42
0000BD3E  E8F201            call 0xbf33
0000BD41  C3                ret
0000BD42  E8CEC8            call 0x8613
0000BD45  C3                ret

0000BD46  8B871144          mov ax,[bx+0x4411]
0000BD4A  8BB75944          mov si,[bx+0x4459]
0000BD4E  D1E6              shl si,1
0000BD50  81C60041          add si,0x4100
0000BD54  05A700            add ax,0xa7
0000BD57  81BF29449C42      cmp word [bx+0x4429],0x429c
0000BD5D  7406              jz 0xbd65
0000BD5F  2D0600            sub ax,0x6			; Draws the sprite.
0000BD62  83C606            add si,byte +0x6		;
0000BD65  8BF8              mov di,ax			;
0000BD67  B800B8            mov ax,0xb800		;
0000BD6A  8EC0              mov es,ax			;
0000BD6C  B90101            mov cx,0x101		;
0000BD6F  E85BE4            call 0xa1cd			;
0000BD72  C3                ret
0000BD73  803EB81C00        cmp byte [0x1cb8],0x0
0000BD78  751C              jnz 0xbd96
0000BD7A  803EBE4400        cmp byte [0x44be],0x0
0000BD7F  740B              jz 0xbd8c
0000BD81  A0BE44            mov al,[0x44be]
0000BD84  A29806            mov [0x698],al
0000BD87  C606990600        mov byte [0x699],0x0
0000BD8C  2AE4              sub ah,ah
0000BD8E  CD1A              int 0x1a
0000BD90  3B16D344          cmp dx,[0x44d3]
0000BD94  7501              jnz 0xbd97
0000BD96  C3                ret
0000BD97  8916D344          mov [0x44d3],dx
0000BD9B  803E840500        cmp byte [0x584],0x0
0000BDA0  7423              jz 0xbdc5
0000BDA2  803EBD4400        cmp byte [0x44bd],0x0
0000BDA7  741B              jz 0xbdc4
0000BDA9  E88701            call 0xbf33
0000BDAC  E821EA            call 0xa7d0
0000BDAF  E8A2C7            call 0x8554
0000BDB2  E8B4E9            call 0xa769
0000BDB5  C606BD4400        mov byte [0x44bd],0x0
0000BDBA  C606E04301        mov byte [0x43e0],0x1
0000BDBF  C606BE4400        mov byte [0x44be],0x0
0000BDC4  C3                ret
0000BDC5  803E9A0600        cmp byte [0x69a],0x0
0000BDCA  7403              jz 0xbdcf
0000BDCC  EB5B              jmp short 0xbe29
0000BDCE  90                nop
0000BDCF  B8FFFF            mov ax,0xffff
0000BDD2  A3C144            mov [0x44c1],ax
0000BDD5  A3BF44            mov [0x44bf],ax
0000BDD8  B90C00            mov cx,0xc
0000BDDB  8B367905          mov si,[0x579]
0000BDDF  8A167B05          mov dl,[0x57b]
0000BDE3  80C208            add dl,0x8
0000BDE6  8BD9              mov bx,cx
0000BDE8  4B                dec bx
0000BDE9  80BFC44401        cmp byte [bx+0x44c4],0x1
0000BDEE  7230              jc 0xbe20
0000BDF0  3A979944          cmp dl,[bx+0x4499]
0000BDF4  752A              jnz 0xbe20
0000BDF6  8BC6              mov ax,si
0000BDF8  D0E3              shl bl,1
0000BDFA  B6FF              mov dh,0xff
0000BDFC  2B878144          sub ax,[bx+0x4481]
0000BE00  7304              jnc 0xbe06
0000BE02  F7D0              not ax
0000BE04  B601              mov dh,0x1
0000BE06  3B06BF44          cmp ax,[0x44bf]
0000BE0A  7714              ja 0xbe20
0000BE0C  A3BF44            mov [0x44bf],ax
0000BE0F  8B87A544          mov ax,[bx+0x44a5]
0000BE13  A3D144            mov [0x44d1],ax
0000BE16  D0EB              shr bl,1
0000BE18  891EC144          mov [0x44c1],bx
0000BE1C  8836C344          mov [0x44c3],dh
0000BE20  E2C4              loop 0xbde6
0000BE22  833EC1440C        cmp word [0x44c1],byte +0xc
0000BE27  7227              jc 0xbe50
0000BE29  803EBD4400        cmp byte [0x44bd],0x0
0000BE2E  740B              jz 0xbe3b
0000BE30  E80001            call 0xbf33
0000BE33  E83FC7            call 0x8575
0000BE36  C6069A0610        mov byte [0x69a],0x10
0000BE3B  C606BD4400        mov byte [0x44bd],0x0
0000BE40  C606E04301        mov byte [0x43e0],0x1
0000BE45  C606D04400        mov byte [0x44d0],0x0
0000BE4A  C606BE4400        mov byte [0x44be],0x0
0000BE4F  C3                ret
0000BE50  833EBF4404        cmp word [0x44bf],byte +0x4
0000BE55  7224              jc 0xbe7b
0000BE57  833EBF4408        cmp word [0x44bf],byte +0x8
0000BE5C  7705              ja 0xbe63
0000BE5E  C606720504        mov byte [0x572],0x4
0000BE63  A0C344            mov al,[0x44c3]
0000BE66  A29806            mov [0x698],al
0000BE69  A26E05            mov [0x56e],al
0000BE6C  A2BE44            mov [0x44be],al
0000BE6F  C606990600        mov byte [0x699],0x0
0000BE74  C606710500        mov byte [0x571],0x0
0000BE79  EBAE              jmp short 0xbe29
0000BE7B  C606BE4400        mov byte [0x44be],0x0
0000BE80  803EBD4400        cmp byte [0x44bd],0x0
0000BE85  7506              jnz 0xbe8d
0000BE87  E889C7            call 0x8613
0000BE8A  E8C7C6            call 0x8554
0000BE8D  C606BD4401        mov byte [0x44bd],0x1
0000BE92  2AC0              sub al,al
0000BE94  8006D04430        add byte [0x44d0],0x30
0000BE99  7302              jnc 0xbe9d
0000BE9B  FEC0              inc al
0000BE9D  A2D544            mov [0x44d5],al
0000BEA0  8B0E7905          mov cx,[0x579]
0000BEA4  81E1FC0F          and cx,0xffc
0000BEA8  8A167B05          mov dl,[0x57b]
0000BEAC  80C203            add dl,0x3
0000BEAF  813ED1440C41      cmp word [0x44d1],0x410c
0000BEB5  740E              jz 0xbec5
0000BEB7  83C108            add cx,byte +0x8
0000BEBA  81F92701          cmp cx,0x127
0000BEBE  720C              jc 0xbecc
0000BEC0  B92601            mov cx,0x126
0000BEC3  EB07              jmp short 0xbecc
0000BEC5  83E908            sub cx,byte +0x8
0000BEC8  7302              jnc 0xbecc
0000BECA  2BC9              sub cx,cx
0000BECC  E811E2            call 0xa0e0
0000BECF  A3DC43            mov [0x43dc],ax
0000BED2  E833C9            call 0x8808   ; Get vertical retrace status.
0000BED5  74FB              jz 0xbed2
0000BED7  E85900            call 0xbf33
0000BEDA  803ED54400        cmp byte [0x44d5],0x0
0000BEDF  744E              jz 0xbf2f
0000BEE1  8B1EC144          mov bx,[0x44c1]
0000BEE5  80BFC44400        cmp byte [bx+0x44c4],0x0
0000BEEA  7443              jz 0xbf2f
0000BEEC  FE8FC444          dec byte [bx+0x44c4]
0000BEF0  7525              jnz 0xbf17
0000BEF2  53                push bx
0000BEF3  B8FD08            mov ax,0x8fd
0000BEF6  BB2307            mov bx,0x723
0000BEF9  E86F0E            call 0xcd6b
0000BEFC  5B                pop bx
0000BEFD  C606980600        mov byte [0x698],0x0
0000BF02  C606BE4400        mov byte [0x44be],0x0
0000BF07  C6069A0610        mov byte [0x69a],0x10
0000BF0C  FE0ED644          dec byte [0x44d6]
0000BF10  7505              jnz 0xbf17
0000BF12  C606530501        mov byte [0x553],0x1
0000BF17  53                push bx
0000BF18  E8C5FC            call 0xbbe0
0000BF1B  5B                pop bx
0000BF1C  730E              jnc 0xbf2c
0000BF1E  53                push bx
0000BF1F  E8AEE8            call 0xa7d0
0000BF22  5B                pop bx
0000BF23  E8D200            call 0xbff8
0000BF26  E840E8            call 0xa769
0000BF29  EB04              jmp short 0xbf2f
0000BF2B  90                nop
0000BF2C  E8C900            call 0xbff8
0000BF2F  E81B00            call 0xbf4d
0000BF32  C3                ret

0000BF33  803EE04300        cmp byte [0x43e0],0x0	; Draws the sprite.
0000BF38  7512              jnz 0xbf4c			;
0000BF3A  8B3EDE43          mov di,[0x43de]		;
0000BF3E  BEA043            mov si,0x43a0		;
0000BF41  B800B8            mov ax,0xb800		;
0000BF44  8EC0              mov es,ax			;
0000BF46  B9030A            mov cx,0xa03		;
0000BF49  E881E2            call 0xa1cd                 ;
0000BF4C  C3                ret

0000BF4D  C606E04300        mov byte [0x43e0],0x0
0000BF52  B800B8            mov ax,0xb800
0000BF55  8EC0              mov es,ax
0000BF57  8B3EDC43          mov di,[0x43dc]
0000BF5B  893EDE43          mov [0x43de],di
0000BF5F  BDA043            mov bp,0x43a0
0000BF62  8B36D144          mov si,[0x44d1]
0000BF66  803ED04480        cmp byte [0x44d0],0x80
0000BF6B  7203              jc 0xbf70
0000BF6D  83C63C            add si,byte +0x3c
0000BF70  B9030A            mov cx,0xa03
0000BF73  E8EFE1            call 0xa165
0000BF76  C3                ret

0000BF77  1E                push ds
0000BF78  07                pop es
0000BF79  2BC0              sub ax,ax
0000BF7B  BF4144            mov di,0x4441
0000BF7E  B90C00            mov cx,0xc
0000BF81  F3AB              rep stosw
0000BF83  B800B8            mov ax,0xb800
0000BF86  8EC0              mov es,ax
0000BF88  8B1E0800          mov bx,[0x8]
0000BF8C  8A8F7144          mov cl,[bx+0x4471]
0000BF90  2AED              sub ch,ch
0000BF92  E898E2            call 0xa22d            ; Get a random number.
0000BF95  8ADA              mov bl,dl
0000BF97  81E31E00          and bx,0x1e
0000BF9B  80FB18            cmp bl,0x18
0000BF9E  73F2              jnc 0xbf92
0000BFA0  83BF414400        cmp word [bx+0x4441],byte +0x0
0000BFA5  75EB              jnz 0xbf92
0000BFA7  C78759440000      mov word [bx+0x4459],0x0
0000BFAD  C78741440100      mov word [bx+0x4441],0x1
0000BFB3  51                push cx
0000BFB4  8BB72944          mov si,[bx+0x4429]		; Draws the sprite.
0000BFB8  8BBF1144          mov di,[bx+0x4411]		;
0000BFBC  B9050D            mov cx,0xd05		;
0000BFBF  E80BE2            call 0xa1cd                 ;  
0000BFC2  59                pop cx
0000BFC3  E2CD              loop 0xbf92
0000BFC5  B90C00            mov cx,0xc
0000BFC8  8BD9              mov bx,cx
0000BFCA  4B                dec bx
0000BFCB  8B360800          mov si,[0x8]
0000BFCF  8A947944          mov dl,[si+0x4479]
0000BFD3  8897C444          mov [bx+0x44c4],dl
0000BFD7  51                push cx
0000BFD8  E81D00            call 0xbff8
0000BFDB  59                pop cx
0000BFDC  E2EA              loop 0xbfc8
0000BFDE  C606D04400        mov byte [0x44d0],0x0
0000BFE3  C606BD4400        mov byte [0x44bd],0x0
0000BFE8  C606E04301        mov byte [0x43e0],0x1
0000BFED  C606D6440C        mov byte [0x44d6],0xc
0000BFF2  C606BE4400        mov byte [0x44be],0x0
0000BFF7  C3                ret

0000BFF8  E81D00            call 0xc018
0000BFFB  8BF8              mov di,ax                   ; Draws the sprite.
0000BFFD  8A87C444          mov al,[bx+0x44c4]		;
0000C001  2AE4              sub ah,ah			;
0000C003  B105              mov cl,0x5			;
0000C005  D3E0              shl ax,cl			;
0000C007  05FC41            add ax,0x41fc		;
0000C00A  8BF0              mov si,ax			;
0000C00C  B90208            mov cx,0x802		;
0000C00F  B800B8            mov ax,0xb800		;
0000C012  8EC0              mov es,ax			;
0000C014  E8B6E1            call 0xa1cd			;
0000C017  C3                ret

0000C018  53                push bx
0000C019  8A979944          mov dl,[bx+0x4499]
0000C01D  D0E3              shl bl,1
0000C01F  8B8F8144          mov cx,[bx+0x4481]
0000C023  E8BAE0            call 0xa0e0
0000C026  5B                pop bx
0000C027  C3                ret
0000C028  0000              add [bx+si],al
0000C02A  0000              add [bx+si],al
0000C02C  0000              add [bx+si],al
0000C02E  0000              add [bx+si],al
0000C030  C3                ret
0000C031  C3                ret
0000C032  C3                ret
0000C033  C3                ret
0000C034  F8                clc
0000C035  C3                ret
0000C036  F8                clc
0000C037  C3                ret
0000C038  C3                ret
0000C039  0000              add [bx+si],al
0000C03B  0000              add [bx+si],al
0000C03D  0000              add [bx+si],al
0000C03F  002A              add [bp+si],ch
0000C041  E4CD              in al,0xcd
0000C043  1A3B              sbb bh,[bp+di]
0000C045  16                push ss
0000C046  B84575            mov ax,0x7545
0000C049  01C3              add bx,ax
0000C04B  FF06B645          inc word [0x45b6]
0000C04F  8B1EB645          mov bx,[0x45b6]
0000C053  83FB01            cmp bx,byte +0x1
0000C056  7410              jz 0xc068
0000C058  83FB04            cmp bx,byte +0x4
0000C05B  740B              jz 0xc068
0000C05D  83FB07            cmp bx,byte +0x7
0000C060  720A              jc 0xc06c
0000C062  2BDB              sub bx,bx
0000C064  891EB645          mov [0x45b6],bx
0000C068  8916B845          mov [0x45b8],dx
0000C06C  E88E03            call 0xc3fd
0000C06F  E8EB03            call 0xc45d
0000C072  7301              jnc 0xc075
0000C074  C3                ret
0000C075  833E4F4500        cmp word [0x454f],byte +0x0
0000C07A  7440              jz 0xc0bc
0000C07C  2AE4              sub ah,ah
0000C07E  CD1A              int 0x1a
0000C080  2B164F45          sub dx,[0x454f]
0000C084  8B1E0800          mov bx,[0x8]
0000C088  D0E3              shl bl,1
0000C08A  8B87C745          mov ax,[bx+0x45c7]
0000C08E  833EB64500        cmp word [0x45b6],byte +0x0
0000C093  7502              jnz 0xc097
0000C095  D1E0              shl ax,1
0000C097  3BD0              cmp dx,ax
0000C099  72D9              jc 0xc074
0000C09B  C7064F450000      mov word [0x454f],0x0
0000C0A1  C6064E4501        mov byte [0x454e],0x1
0000C0A6  B82400            mov ax,0x24
0000C0A9  813E7905A000      cmp word [0x579],0xa0
0000C0AF  7703              ja 0xc0b4
0000C0B1  B80801            mov ax,0x108
0000C0B4  A34845            mov [0x4548],ax
0000C0B7  C6064A4500        mov byte [0x454a],0x0
0000C0BC  E84101            call 0xc200
0000C0BF  7308              jnc 0xc0c9
0000C0C1  8B1EB645          mov bx,[0x45b6]
0000C0C5  E82303            call 0xc3eb
0000C0C8  C3                ret
0000C0C9  803E534500        cmp byte [0x4553],0x0
0000C0CE  7418              jz 0xc0e8
0000C0D0  FE0E5345          dec byte [0x4553]
0000C0D4  750F              jnz 0xc0e5
0000C0D6  B201              mov dl,0x1
0000C0D8  803E4A45FF        cmp byte [0x454a],0xff
0000C0DD  7402              jz 0xc0e1
0000C0DF  B2FF              mov dl,0xff
0000C0E1  88164A45          mov [0x454a],dl
0000C0E5  EB5D              jmp short 0xc144
0000C0E7  90                nop
0000C0E8  A04B45            mov al,[0x454b]
0000C0EB  3A067B05          cmp al,[0x57b]
0000C0EF  7753              ja 0xc144
0000C0F1  833EB64506        cmp word [0x45b6],byte +0x6
0000C0F6  7507              jnz 0xc0ff
0000C0F8  803E7B0528        cmp byte [0x57b],0x28
0000C0FD  720D              jc 0xc10c
0000C0FF  E82BE1            call 0xa22d            ; Get a random number.
0000C102  8B1E0800          mov bx,[0x8]
0000C106  3A97BF45          cmp dl,[bx+0x45bf]
0000C10A  7738              ja 0xc144
0000C10C  2AD2              sub dl,dl
0000C10E  A14845            mov ax,[0x4548]
0000C111  25F80F            and ax,0xff8
0000C114  8B0E7905          mov cx,[0x579]
0000C118  81E1F80F          and cx,0xff8
0000C11C  3BC1              cmp ax,cx
0000C11E  7406              jz 0xc126
0000C120  B201              mov dl,0x1
0000C122  7202              jc 0xc126
0000C124  B2FF              mov dl,0xff
0000C126  88164A45          mov [0x454a],dl
0000C12A  803E7B0528        cmp byte [0x57b],0x28
0000C12F  7213              jc 0xc144
0000C131  833EB64506        cmp word [0x45b6],byte +0x6
0000C136  750C              jnz 0xc144
0000C138  B001              mov al,0x1
0000C13A  80FAFF            cmp dl,0xff
0000C13D  7402              jz 0xc141
0000C13F  B0FF              mov al,0xff
0000C141  A24A45            mov [0x454a],al
0000C144  C706BC450800      mov word [0x45bc],0x8
0000C14A  803E534500        cmp byte [0x4553],0x0
0000C14F  7406              jz 0xc157
0000C151  C706BC450400      mov word [0x45bc],0x4
0000C157  A14845            mov ax,[0x4548]
0000C15A  803E4A4501        cmp byte [0x454a],0x1
0000C15F  7315              jnc 0xc176
0000C161  E8C9E0            call 0xa22d            ; Get a random number.
0000C164  80FA10            cmp dl,0x10
0000C167  7768              ja 0xc1d1
0000C169  80E201            and dl,0x1
0000C16C  7502              jnz 0xc170
0000C16E  B2FF              mov dl,0xff
0000C170  88164A45          mov [0x454a],dl
0000C174  EB5B              jmp short 0xc1d1
0000C176  7518              jnz 0xc190
0000C178  0306BC45          add ax,[0x45bc]
0000C17C  3D0B01            cmp ax,0x10b
0000C17F  7227              jc 0xc1a8
0000C181  B80A01            mov ax,0x10a
0000C184  C6064A45FF        mov byte [0x454a],0xff
0000C189  C606534500        mov byte [0x4553],0x0
0000C18E  EB18              jmp short 0xc1a8
0000C190  2B06BC45          sub ax,[0x45bc]
0000C194  7205              jc 0xc19b
0000C196  3D2400            cmp ax,0x24
0000C199  770D              ja 0xc1a8
0000C19B  B82500            mov ax,0x25
0000C19E  C6064A4501        mov byte [0x454a],0x1
0000C1A3  C606534500        mov byte [0x4553],0x0
0000C1A8  A34845            mov [0x4548],ax
0000C1AB  8306514502        add word [0x4551],byte +0x2
0000C1B0  833E51450C        cmp word [0x4551],byte +0xc
0000C1B5  7206              jc 0xc1bd
0000C1B7  C70651450000      mov word [0x4551],0x0
0000C1BD  803E534500        cmp byte [0x4553],0x0
0000C1C2  750D              jnz 0xc1d1
0000C1C4  E866E0            call 0xa22d            ; Get a random number.
0000C1C7  80FA08            cmp dl,0x8
0000C1CA  7705              ja 0xc1d1
0000C1CC  C6064A4500        mov byte [0x454a],0x0
0000C1D1  8B0E4845          mov cx,[0x4548]
0000C1D5  8A164B45          mov dl,[0x454b]
0000C1D9  E804DF            call 0xa0e0
0000C1DC  A3BA45            mov [0x45ba],ax
0000C1DF  E87B02            call 0xc45d
0000C1E2  7301              jnc 0xc1e5
0000C1E4  C3                ret
0000C1E5  E81800            call 0xc200
0000C1E8  720E              jc 0xc1f8
0000C1EA  E88D01            call 0xc37a
0000C1ED  E85001            call 0xc340
0000C1F0  C606BE4500        mov byte [0x45be],0x0
0000C1F5  E8AD00            call 0xc2a5
0000C1F8  8B1EB645          mov bx,[0x45b6]
0000C1FC  E8EC01            call 0xc3eb
0000C1FF  C3                ret
0000C200  A17905            mov ax,[0x579]
0000C203  8A167B05          mov dl,[0x57b]
0000C207  BE1800            mov si,0x18
0000C20A  8BFE              mov di,si
0000C20C  8B1E4845          mov bx,[0x4548]
0000C210  8A364B45          mov dh,[0x454b]
0000C214  B90E0C            mov cx,0xc0e
0000C217  E83FE0            call 0xa259
0000C21A  7351              jnc 0xc26d
0000C21C  833EB64506        cmp word [0x45b6],byte +0x6
0000C221  750D              jnz 0xc230
0000C223  C606530501        mov byte [0x553],0x1
0000C228  E8E8C3            call 0x8613
0000C22B  E84C01            call 0xc37a
0000C22E  F9                stc
0000C22F  C3                ret
0000C230  E8E0C3            call 0x8613
0000C233  E84401            call 0xc37a
0000C236  E83CC3            call 0x8575
0000C239  C6065B0504        mov byte [0x55b],0x4
0000C23E  C606710501        mov byte [0x571],0x1
0000C243  C606760504        mov byte [0x576],0x4
0000C248  C606780508        mov byte [0x578],0x8
0000C24D  C606534504        mov byte [0x4553],0x4
0000C252  B201              mov dl,0x1
0000C254  A14845            mov ax,[0x4548]
0000C257  3B067905          cmp ax,[0x579]
0000C25B  7702              ja 0xc25f
0000C25D  B2FF              mov dl,0xff
0000C25F  88164A45          mov [0x454a],dl
0000C263  B8E40C            mov ax,0xce4
0000C266  BB3B12            mov bx,0x123b
0000C269  E8FF0A            call 0xcd6b
0000C26C  F9                stc
0000C26D  C3                ret
0000C26E  C606BE4501        mov byte [0x45be],0x1
0000C273  A1B645            mov ax,[0x45b6]
0000C276  50                push ax
0000C277  C706B6450000      mov word [0x45b6],0x0
0000C27D  8B1EB645          mov bx,[0x45b6]
0000C281  E87901            call 0xc3fd
0000C284  833E4F4500        cmp word [0x454f],byte +0x0
0000C289  750A              jnz 0xc295
0000C28B  E81700            call 0xc2a5
0000C28E  8B1EB645          mov bx,[0x45b6]
0000C292  E85601            call 0xc3eb
0000C295  FF06B645          inc word [0x45b6]
0000C299  833EB64507        cmp word [0x45b6],byte +0x7
0000C29E  72DD              jc 0xc27d
0000C2A0  58                pop ax
0000C2A1  A3B645            mov [0x45b6],ax
0000C2A4  C3                ret
0000C2A5  B90800            mov cx,0x8
0000C2A8  8BD9              mov bx,cx
0000C2AA  4B                dec bx
0000C2AB  80BF722B00        cmp byte [bx+0x2b72],0x0
0000C2B0  7421              jz 0xc2d3
0000C2B2  51                push cx
0000C2B3  8A976A2B          mov dl,[bx+0x2b6a]
0000C2B7  D0E3              shl bl,1
0000C2B9  8B875A2B          mov ax,[bx+0x2b5a]
0000C2BD  BE1800            mov si,0x18
0000C2C0  8BFE              mov di,si
0000C2C2  8B1E4845          mov bx,[0x4548]
0000C2C6  8A364B45          mov dh,[0x454b]
0000C2CA  B90F0C            mov cx,0xc0f
0000C2CD  E889DF            call 0xa259
0000C2D0  59                pop cx
0000C2D1  7203              jc 0xc2d6
0000C2D3  E2D3              loop 0xc2a8
0000C2D5  C3                ret
0000C2D6  51                push cx
0000C2D7  803EBE4500        cmp byte [0x45be],0x0
0000C2DC  750D              jnz 0xc2eb
0000C2DE  E832C3            call 0x8613
0000C2E1  803EF27000        cmp byte [0x70f2],0x0
0000C2E6  7403              jz 0xc2eb
0000C2E8  E87013            call 0xd65b
0000C2EB  E88C00            call 0xc37a
0000C2EE  59                pop cx
0000C2EF  8BD9              mov bx,cx
0000C2F1  4B                dec bx
0000C2F2  C687722B00        mov byte [bx+0x2b72],0x0
0000C2F7  8A976A2B          mov dl,[bx+0x2b6a]
0000C2FB  D0E3              shl bl,1
0000C2FD  8B8F5A2B          mov cx,[bx+0x2b5a]
0000C301  E8DCDD            call 0xa0e0
0000C304  8BF8              mov di,ax			; Draws the sprite.
0000C306  BE7A2B            mov si,0x2b7a		;
0000C309  B800B8            mov ax,0xb800		;
0000C30C  8EC0              mov es,ax			;
0000C30E  B9030F            mov cx,0xf03		;
0000C311  E8B9DE            call 0xa1cd                 ;
0000C314  803EBE4500        cmp byte [0x45be],0x0
0000C319  750D              jnz 0xc328
0000C31B  803EF27000        cmp byte [0x70f2],0x0
0000C320  7403              jz 0xc325
0000C322  E80513            call 0xd62a
0000C325  E84DC2            call 0x8575
0000C328  2BD2              sub dx,dx
0000C32A  833EB64506        cmp word [0x45b6],byte +0x6
0000C32F  740A              jz 0xc33b
0000C331  2AE4              sub ah,ah
0000C333  CD1A              int 0x1a
0000C335  83FA00            cmp dx,byte +0x0
0000C338  7501              jnz 0xc33b
0000C33A  4A                dec dx
0000C33B  89164F45          mov [0x454f],dx
0000C33F  C3                ret
0000C340  C6064E4500        mov byte [0x454e],0x0
0000C345  BE0045            mov si,0x4500
0000C348  803E4A4500        cmp byte [0x454a],0x0
0000C34D  741F              jz 0xc36e
0000C34F  8B1E5145          mov bx,[0x4551]
0000C353  803E534500        cmp byte [0x4553],0x0
0000C358  7406              jz 0xc360
0000C35A  80E302            and bl,0x2
0000C35D  80C30C            add bl,0xc
0000C360  803E4A45FF        cmp byte [0x454a],0xff
0000C365  7503              jnz 0xc36a
0000C367  83C310            add bx,byte +0x10
0000C36A  8BB7604A          mov si,[bx+0x4a60]
0000C36E  8B3EBA45          mov di,[0x45ba]
0000C372  893E4C45          mov [0x454c],di
0000C376  E89600            call 0xc40f
0000C379  C3                ret
0000C37A  803E4E4500        cmp byte [0x454e],0x0
0000C37F  7507              jnz 0xc388
0000C381  8B3E4C45          mov di,[0x454c]
0000C385  E8B000            call 0xc438
0000C388  C3                ret

0000C389  C706B6450000      mov word [0x45b6],0x0
0000C38F  E89BDE            call 0xa22d            ; Get a random number.
0000C392  81E27F00          and dx,0x7f
0000C396  83C260            add dx,byte +0x60
0000C399  89164845          mov [0x4548],dx
0000C39D  C6064A4500        mov byte [0x454a],0x0
0000C3A2  C6064E4501        mov byte [0x454e],0x1
0000C3A7  C70651450000      mov word [0x4551],0x0
0000C3AD  C606534500        mov byte [0x4553],0x0
0000C3B2  2BD2              sub dx,dx
0000C3B4  833EB64500        cmp word [0x45b6],byte +0x0
0000C3B9  750A              jnz 0xc3c5
0000C3BB  2AE4              sub ah,ah
0000C3BD  CD1A              int 0x1a
0000C3BF  83FA00            cmp dx,byte +0x0
0000C3C2  7501              jnz 0xc3c5
0000C3C4  4A                dec dx
0000C3C5  89164F45          mov [0x454f],dx
0000C3C9  8B1EB645          mov bx,[0x45b6]
0000C3CD  8A87D42B          mov al,[bx+0x2bd4]
0000C3D1  0403              add al,0x3
0000C3D3  A24B45            mov [0x454b],al
0000C3D6  E81200            call 0xc3eb
0000C3D9  FF06B645          inc word [0x45b6]
0000C3DD  833EB64507        cmp word [0x45b6],byte +0x7
0000C3E2  72AB              jc 0xc38f
0000C3E4  C706B6450000      mov word [0x45b6],0x0
0000C3EA  C3                ret
0000C3EB  1E                push ds
0000C3EC  07                pop es
0000C3ED  D0E3              shl bl,1
0000C3EF  FC                cld
0000C3F0  8BBFA845          mov di,[bx+0x45a8]
0000C3F4  BE4845            mov si,0x4548
0000C3F7  B90C00            mov cx,0xc
0000C3FA  F3A4              rep movsb
0000C3FC  C3                ret
0000C3FD  1E                push ds
0000C3FE  07                pop es
0000C3FF  D0E3              shl bl,1
0000C401  FC                cld
0000C402  8BB7A845          mov si,[bx+0x45a8]
0000C406  BF4845            mov di,0x4548
0000C409  B90C00            mov cx,0xc
0000C40C  F3A4              rep movsb
0000C40E  C3                ret
0000C40F  B800B8            mov ax,0xb800
0000C412  8EC0              mov es,ax
0000C414  FC                cld
0000C415  B60C              mov dh,0xc
0000C417  B90300            mov cx,0x3
0000C41A  268B1D            mov bx,[es:di]
0000C41D  AD                lodsw
0000C41E  0BC3              or ax,bx
0000C420  AB                stosw
0000C421  E2F7              loop 0xc41a
0000C423  83EF06            sub di,byte +0x6
0000C426  81F70020          xor di,0x2000
0000C42A  F7C70020          test di,0x2000
0000C42E  7503              jnz 0xc433
0000C430  83C750            add di,byte +0x50
0000C433  FECE              dec dh
0000C435  75E0              jnz 0xc417
0000C437  C3                ret
0000C438  B800B8            mov ax,0xb800
0000C43B  8EC0              mov es,ax
0000C43D  FC                cld
0000C43E  B60C              mov dh,0xc
0000C440  B85555            mov ax,0x5555
0000C443  B90300            mov cx,0x3
0000C446  F3AB              rep stosw
0000C448  83EF06            sub di,byte +0x6
0000C44B  81F70020          xor di,0x2000
0000C44F  F7C70020          test di,0x2000
0000C453  7503              jnz 0xc458
0000C455  83C750            add di,byte +0x50
0000C458  FECE              dec dh
0000C45A  75E7              jnz 0xc443
0000C45C  C3                ret
0000C45D  803EF27000        cmp byte [0x70f2],0x0
0000C462  7502              jnz 0xc466
0000C464  F8                clc
0000C465  C3                ret
0000C466  A1F370            mov ax,[0x70f3]
0000C469  8A16F570          mov dl,[0x70f5]
0000C46D  BE1000            mov si,0x10
0000C470  8B1E4845          mov bx,[0x4548]
0000C474  8A364B45          mov dh,[0x454b]
0000C478  BF1800            mov di,0x18
0000C47B  B9080C            mov cx,0xc08
0000C47E  E8D8DD            call 0xa259
0000C481  C3                ret
0000C482  0000              add [bx+si],al
0000C484  0000              add [bx+si],al
0000C486  0000              add [bx+si],al
0000C488  0000              add [bx+si],al
0000C48A  0000              add [bx+si],al
0000C48C  0000              add [bx+si],al
0000C48E  0000              add [bx+si],al
0000C490  B800B8            mov ax,0xb800
0000C493  8EC0              mov es,ax
0000C495  A17905            mov ax,[0x579]
0000C498  3D1701            cmp ax,0x117
0000C49B  7203              jc 0xc4a0
0000C49D  B81601            mov ax,0x116
0000C4A0  2D1000            sub ax,0x10
0000C4A3  7302              jnc 0xc4a7
0000C4A5  2BC0              sub ax,ax
0000C4A7  25F00F            and ax,0xff0
0000C4AA  A37905            mov [0x579],ax
0000C4AD  C6067B0514        mov byte [0x57b],0x14
0000C4B2  2D8000            sub ax,0x80
0000C4B5  7302              jnc 0xc4b9
0000C4B7  F7D0              not ax
0000C4B9  B103              mov cl,0x3
0000C4BB  D3E8              shr ax,cl
0000C4BD  3D0D00            cmp ax,0xd
0000C4C0  7603              jna 0xc4c5
0000C4C2  B80D00            mov ax,0xd
0000C4C5  050200            add ax,0x2
0000C4C8  A36A4D            mov [0x4d6a],ax
0000C4CB  C706D64D0A00      mov word [0x4dd6],0xa
0000C4D1  833ED64D0A        cmp word [0x4dd6],byte +0xa
0000C4D6  7403              jz 0xc4db
0000C4D8  E8B80A            call 0xcf93
0000C4DB  2AE4              sub ah,ah
0000C4DD  CD1A              int 0x1a
0000C4DF  8916804A          mov [0x4a80],dx
0000C4E3  A17905            mov ax,[0x579]
0000C4E6  8BC8              mov cx,ax
0000C4E8  81E1F00F          and cx,0xff0
0000C4EC  81F98000          cmp cx,0x80
0000C4F0  7504              jnz 0xc4f6
0000C4F2  8BC1              mov ax,cx
0000C4F4  EB0C              jmp short 0xc502
0000C4F6  7206              jc 0xc4fe
0000C4F8  2B066A4D          sub ax,[0x4d6a]
0000C4FC  EB04              jmp short 0xc502
0000C4FE  03066A4D          add ax,[0x4d6a]
0000C502  A37905            mov [0x579],ax
0000C505  803E7B0554        cmp byte [0x57b],0x54
0000C50A  7201              jc 0xc50d
0000C50C  C3                ret

0000C50D  80067B0508        add byte [0x57b],0x8
0000C512  8B0E7905          mov cx,[0x579]
0000C516  83C104            add cx,byte +0x4
0000C519  8A167B05          mov dl,[0x57b]
0000C51D  E8C0DB            call 0xa0e0
0000C520  8BF8              mov di,ax
0000C522  893ED84D          mov [0x4dd8],di
0000C526  BE8A4B            mov si,0x4b8a
0000C529  BD0E00            mov bp,0xe
0000C52C  B90720            mov cx,0x2007
0000C52F  E8CADB            call 0xa0fc
0000C532  8B3ED84D          mov di,[0x4dd8]		; Draws the Freddy and girl friend sprite.
0000C536  81C7F300          add di,0xf3			;
0000C53A  BE824A            mov si,0x4a82		;
0000C53D  B9040D            mov cx,0xd04		;
0000C540  E88ADC            call 0xa1cd			;
0000C543  833ED64D0A        cmp word [0x4dd6],byte +0xa
0000C548  7506              jnz 0xc550
0000C54A  E81106            call 0xcb5e
0000C54D  E8340A            call 0xcf84
0000C550  E8400A            call 0xcf93
0000C553  2AE4              sub ah,ah
0000C555  CD1A              int 0x1a
0000C557  2B16804A          sub dx,[0x4a80]
0000C55B  3B16D64D          cmp dx,[0x4dd6]
0000C55F  72EF              jc 0xc550
0000C561  833ED64D0A        cmp word [0x4dd6],byte +0xa
0000C566  7509              jnz 0xc571
0000C568  E875E7            call 0xace0
0000C56B  2BDB              sub bx,bx
0000C56D  B40B              mov ah,0xb
0000C56F  CD10              int 0x10
0000C571  C706D64D0200      mov word [0x4dd6],0x2
0000C577  E957FF            jmp 0xc4d1
0000C57A  B90300            mov cx,0x3
0000C57D  BB0300            mov bx,0x3
0000C580  2BD9              sub bx,cx
0000C582  D1E3              shl bx,1
0000C584  8B87A44D          mov ax,[bx+0x4da4]
0000C588  A36A4D            mov [0x4d6a],ax
0000C58B  8B87AA4D          mov ax,[bx+0x4daa]
0000C58F  A36C4D            mov [0x4d6c],ax
0000C592  8B87984D          mov ax,[bx+0x4d98]
0000C596  A3CC4D            mov [0x4dcc],ax
0000C599  8B879E4D          mov ax,[bx+0x4d9e]
0000C59D  A3CE4D            mov [0x4dce],ax
0000C5A0  8B87B04D          mov ax,[bx+0x4db0]
0000C5A4  A3D04D            mov [0x4dd0],ax
0000C5A7  8B87B64D          mov ax,[bx+0x4db6]
0000C5AB  A3D24D            mov [0x4dd2],ax
0000C5AE  8B87BC4D          mov ax,[bx+0x4dbc]
0000C5B2  A3D44D            mov [0x4dd4],ax
0000C5B5  8B87924D          mov ax,[bx+0x4d92]
0000C5B9  A3CA4D            mov [0x4dca],ax
0000C5BC  8B87C24D          mov ax,[bx+0x4dc2]
0000C5C0  A3C84D            mov [0x4dc8],ax
0000C5C3  51                push cx
0000C5C4  E80400            call 0xc5cb
0000C5C7  59                pop cx
0000C5C8  E2B3              loop 0xc57d
0000C5CA  C3                ret
0000C5CB  B90800            mov cx,0x8
0000C5CE  C606914D01        mov byte [0x4d91],0x1
0000C5D3  51                push cx
0000C5D4  E8BC09            call 0xcf93
0000C5D7  59                pop cx
0000C5D8  8BD9              mov bx,cx
0000C5DA  4B                dec bx
0000C5DB  D1E3              shl bx,1
0000C5DD  A1CC4D            mov ax,[0x4dcc]
0000C5E0  89874A4D          mov [bx+0x4d4a],ax
0000C5E4  A1CE4D            mov ax,[0x4dce]
0000C5E7  89875A4D          mov [bx+0x4d5a],ax
0000C5EB  E2E6              loop 0xc5d3
0000C5ED  B800B8            mov ax,0xb800
0000C5F0  8EC0              mov es,ax
0000C5F2  C6066E4D00        mov byte [0x4d6e],0x0
0000C5F7  2AE4              sub ah,ah
0000C5F9  CD1A              int 0x1a
0000C5FB  8916804A          mov [0x4a80],dx
0000C5FF  B90800            mov cx,0x8
0000C602  51                push cx
0000C603  E88D09            call 0xcf93
0000C606  59                pop cx
0000C607  8BD9              mov bx,cx
0000C609  4B                dec bx
0000C60A  D1E3              shl bx,1
0000C60C  51                push cx
0000C60D  53                push bx
0000C60E  803E914D00        cmp byte [0x4d91],0x0
0000C613  7405              jz 0xc61a
0000C615  83F908            cmp cx,byte +0x8
0000C618  751B              jnz 0xc635
0000C61A  8B8F4A4D          mov cx,[bx+0x4d4a]
0000C61E  8B975A4D          mov dx,[bx+0x4d5a]
0000C622  E8BBDA            call 0xa0e0
0000C625  8BF8              mov di,ax
0000C627  8B36CA4D          mov si,[0x4dca]
0000C62B  BD0E00            mov bp,0xe
0000C62E  8B0ED44D          mov cx,[0x4dd4]
0000C632  E8C7DA            call 0xa0fc
0000C635  5B                pop bx
0000C636  59                pop cx
0000C637  E82000            call 0xc65a
0000C63A  E2C6              loop 0xc602
0000C63C  E85409            call 0xcf93
0000C63F  2AE4              sub ah,ah
0000C641  CD1A              int 0x1a
0000C643  2B16804A          sub dx,[0x4a80]
0000C647  3B16C84D          cmp dx,[0x4dc8]
0000C64B  72EF              jc 0xc63c
0000C64D  C606914D00        mov byte [0x4d91],0x0
0000C652  803E6E4D00        cmp byte [0x4d6e],0x0
0000C657  749E              jz 0xc5f7
0000C659  C3                ret
0000C65A  8B874A4D          mov ax,[bx+0x4d4a]
0000C65E  83BF6F4D01        cmp word [bx+0x4d6f],byte +0x1
0000C663  7225              jc 0xc68a
0000C665  7513              jnz 0xc67a
0000C667  03066A4D          add ax,[0x4d6a]
0000C66B  3B06D04D          cmp ax,[0x4dd0]
0000C66F  7615              jna 0xc686
0000C671  A1D04D            mov ax,[0x4dd0]
0000C674  FE066E4D          inc byte [0x4d6e]
0000C678  EB0C              jmp short 0xc686
0000C67A  2B066A4D          sub ax,[0x4d6a]
0000C67E  7306              jnc 0xc686
0000C680  2BC0              sub ax,ax
0000C682  FE066E4D          inc byte [0x4d6e]
0000C686  89874A4D          mov [bx+0x4d4a],ax
0000C68A  8B875A4D          mov ax,[bx+0x4d5a]
0000C68E  83BF7F4D01        cmp word [bx+0x4d7f],byte +0x1
0000C693  7225              jc 0xc6ba
0000C695  7513              jnz 0xc6aa
0000C697  03066C4D          add ax,[0x4d6c]
0000C69B  3B06D24D          cmp ax,[0x4dd2]
0000C69F  7615              jna 0xc6b6
0000C6A1  A1D24D            mov ax,[0x4dd2]
0000C6A4  FE066E4D          inc byte [0x4d6e]
0000C6A8  EB0C              jmp short 0xc6b6
0000C6AA  2B066C4D          sub ax,[0x4d6c]
0000C6AE  7306              jnc 0xc6b6
0000C6B0  2BC0              sub ax,ax
0000C6B2  FE066E4D          inc byte [0x4d6e]
0000C6B6  89875A4D          mov [bx+0x4d5a],ax
0000C6BA  C3                ret

0000C6BB  E8C608            call 0xcf84
0000C6BE  803E9706FD        cmp byte [0x697],0xfd	   ; Do PCjr stuff on a PCjr.
0000C6C3  7407              jz 0xc6cc                      ; 
0000C6C5  B40B              mov ah,0xb                     ;
0000C6C7  BB0101            mov bx,0x101                   ;
0000C6CA  CD10              int 0x10                       ;
0000C6CC  E8C1FD            call 0xc490
0000C6CF  E8A8FE            call 0xc57a
0000C6D2  E81A09            call 0xcfef
0000C6D5  803E801F09        cmp byte [0x1f80],0x9	   ; Add a life if there are less than nine.
0000C6DA  7304              jnc 0xc6e0                     ;
0000C6DC  FE06801F          inc byte [0x1f80]              ;

0000C6E0  833E080007        cmp word [0x8],byte +0x7
0000C6E5  7304              jnc 0xc6eb
0000C6E7  FF060800          inc word [0x8]
0000C6EB  C70614040000      mov word [0x414],0x0
0000C6F1  2AE4              sub ah,ah
0000C6F3  CD1A              int 0x1a
0000C6F5  89161204          mov [0x412],dx
0000C6F9  E85508            call 0xcf51		; Turn off the PC-Speaker.
0000C6FC  C3                ret

0000C700  803E00000         cmp byte [0x0],0x0
0000C705  743B              jz 0xc742
0000C707  2AE4              sub ah,ah
0000C709  CD1A              int 0x1a
0000C70B  3B16C452          cmp dx,[0x52c4]
0000C70F  7431              jz 0xc742
0000C711  8916C452          mov [0x52c4],dx
0000C715  8B1EC652          mov bx,[0x52c6]
0000C719  8306C65202        add word [0x52c6],byte +0x2
0000C71E  8B87CA52          mov ax,[bx+0x52ca]
0000C722  3B06C852          cmp ax,[0x52c8]
0000C726  7504              jnz 0xc72c
0000C728  E82608            call 0xcf51		; Turn off the PC-Speaker.
0000C72B  C3                ret

0000C72C  A3C852            mov [0x52c8],ax	; Play a tone via the PC-Speaker.
0000C72F  B0B6              mov al,0xb6		;
0000C731  E643              out 0x43,al		;
0000C733  A1C852            mov ax,[0x52c8]	;
0000C736  E642              out 0x42,al		;
0000C738  8AC4              mov al,ah		;
0000C73A  E642              out 0x42,al		;
0000C73C  E461              in al,0x61		;
0000C73E  0C03              or al,0x3		;
0000C740  E661              out 0x61,al		;
0000C742  C3                ret

0000C743  833E080002        cmp word [0x8],byte +0x2
0000C748  724D              jc 0xc797
0000C74A  C70616500000      mov word [0x5016],0x0
0000C750  2AE4              sub ah,ah
0000C752  CD1A              int 0x1a
0000C754  8916C052          mov [0x52c0],dx
0000C758  8916C252          mov [0x52c2],dx
0000C75C  8916C452          mov [0x52c4],dx
0000C760  C706C6520000      mov word [0x52c6],0x0
0000C766  C706C8520000      mov word [0x52c8],0x0	; Set the frequency to zero.
0000C76C  E82900            call 0xc798
0000C76F  813616500200      xor word [0x5016],0x2
0000C775  E888FF            call 0xc700
0000C778  2AE4              sub ah,ah
0000C77A  CD1A              int 0x1a
0000C77C  8BC2              mov ax,dx
0000C77E  2B06C052          sub ax,[0x52c0]
0000C782  3D0500            cmp ax,0x5
0000C785  72EE              jc 0xc775
0000C787  8916C052          mov [0x52c0],dx
0000C78B  2B16C252          sub dx,[0x52c2]
0000C78F  83FA28            cmp dx,byte +0x28
0000C792  72D8              jc 0xc76c
0000C794  E8BA07            call 0xcf51		; Turn off the PC-Speaker.
0000C797  C3                ret
0000C798  B800B8            mov ax,0xb800
0000C79B  8EC0              mov es,ax
0000C79D  8B1E0800          mov bx,[0x8]
0000C7A1  D1E3              shl bx,1
0000C7A3  8B87AE52          mov ax,[bx+0x52ae]
0000C7A7  A31050            mov [0x5010],ax
0000C7AA  8B1E1050          mov bx,[0x5010]
0000C7AE  8B3F              mov di,[bx]
0000C7B0  83FF00            cmp di,byte +0x0
0000C7B3  7501              jnz 0xc7b6
0000C7B5  C3                ret

0000C7B6  8B5F02            mov bx,[bx+0x2]		; Draws the sprite.
0000C7B9  331E1650          xor bx,[0x5016]		;
0000C7BD  81E30200          and bx,0x2			;
0000C7C1  8BB71250          mov si,[bx+0x5012]		;
0000C7C5  B90423            mov cx,0x2304		;
0000C7C8  E802DA            call 0xa1cd         	;
0000C7CB  E832FF            call 0xc700
0000C7CE  8306105004        add word [0x5010],byte +0x4
0000C7D3  EBD5              jmp short 0xc7aa
0000C7D5  0000              add [bx+si],al
0000C7D7  0000              add [bx+si],al
0000C7D9  0000              add [bx+si],al
0000C7DB  0000              add [bx+si],al
0000C7DD  0000              add [bx+si],al
0000C7DF  00803E00          add [bx+si+0x3e],al
0000C7E3  0000              add [bx+si],al
0000C7E5  743E              jz 0xc825
0000C7E7  2AE4              sub ah,ah
0000C7E9  CD1A              int 0x1a
0000C7EB  3B162253          cmp dx,[0x5322]
0000C7EF  7434              jz 0xc825
0000C7F1  89162253          mov [0x5322],dx
0000C7F5  8B1E2053          mov bx,[0x5320]
0000C7F9  8A9F8C53          mov bl,[bx+0x538c]
0000C7FD  80FB66            cmp bl,0x66
0000C800  740B              jz 0xc80d
0000C802  2AFF              sub bh,bh
0000C804  FF062053          inc word [0x5320]
0000C808  83FB00            cmp bx,byte +0x0
0000C80B  7504              jnz 0xc811
0000C80D  E84107            call 0xcf51		; Turn off the PC-Speaker.
0000C810  C3                ret

0000C811  B0B6              mov al,0xb6		; Play a frequency via the PC-Speaker.
0000C813  E643              out 0x43,al		;
0000C815  8B872453          mov ax,[bx+0x5324]	;
0000C819  E642              out 0x42,al		;
0000C81B  8AC4              mov al,ah		;
0000C81D  E642              out 0x42,al		;
0000C81F  E461              in al,0x61		;
0000C821  0C03              or al,0x3		;
0000C823  E661              out 0x61,al		;
0000C825  C3                ret			;

; Draw more title screen related stuff.
0000C830  B800B8            mov ax,0xb800
0000C833  8EC0              mov es,ax
0000C835  8B1E0800          mov bx,[0x8]
0000C839  81E30700          and bx,0x7
0000C83D  D1E3              shl bx,1
0000C83F  8BC3              mov ax,bx
0000C841  8B9F0859          mov bx,[bx+0x5908]
0000C845  B103              mov cl,0x3
0000C847  D3E0              shl ax,cl
0000C849  A31859            mov [0x5918],ax
0000C84C  8B3F              mov di,[bx]
0000C84E  81FFFFFF          cmp di,0xffff
0000C852  7423              jz 0xc877
0000C854  E8D6D9            call 0xa22d            	; Get a random number.
0000C857  81E20E00          and dx,0xe             	; Draws the sprite.
0000C85B  03161859          add dx,[0x5918]		;
0000C85F  8BF2              mov si,dx			;
0000C861  8BB48858          mov si,[si+0x5888]		;
0000C865  8B8C5858          mov cx,[si+0x5858]		;
0000C869  8BB44C58          mov si,[si+0x584c]		;
0000C86D  53                push bx			;
0000C86E  E85CD9            call 0xa1cd            	;
0000C871  5B                pop bx
0000C872  83C302            add bx,byte +0x2
0000C875  EBD5              jmp short 0xc84c
0000C877  C3                ret

0000C880  C6060F5B0C        mov byte [0x5b0f],0xc
0000C885  C7060C5B0100      mov word [0x5b0c],0x1
0000C88B  C706125BFF01      mov word [0x5b12],0x1ff
0000C891  C7060A5B0F00      mov word [0x5b0a],0xf
0000C897  C6060E5B01        mov byte [0x5b0e],0x1
0000C89C  C3                ret
0000C89D  803E000000        cmp byte [0x0],0x0
0000C8A2  7431              jz 0xc8d5
0000C8A4  803EB81C00        cmp byte [0x1cb8],0x0
0000C8A9  747D              jz 0xc928
0000C8AB  2AE4              sub ah,ah
0000C8AD  CD1A              int 0x1a
0000C8AF  803E0F5B00        cmp byte [0x5b0f],0x0
0000C8B4  7520              jnz 0xc8d6
0000C8B6  3B16105B          cmp dx,[0x5b10]
0000C8BA  7419              jz 0xc8d5
0000C8BC  8916105B          mov [0x5b10],dx
0000C8C0  B0B6              mov al,0xb6
0000C8C2  E643              out 0x43,al
0000C8C4  A1125B            mov ax,[0x5b12]
0000C8C7  25FF01            and ax,0x1ff
0000C8CA  05C800            add ax,0xc8
0000C8CD  E8E903            call 0xccb9
0000C8D0  832E125B4B        sub word [0x5b12],byte +0x4b
0000C8D5  C3                ret
0000C8D6  3B16105B          cmp dx,[0x5b10]
0000C8DA  7408              jz 0xc8e4
0000C8DC  8916105B          mov [0x5b10],dx
0000C8E0  FE0E0F5B          dec byte [0x5b0f]
0000C8E4  FE0E0E5B          dec byte [0x5b0e]
0000C8E8  753D              jnz 0xc927
0000C8EA  B001              mov al,0x1
0000C8EC  803E9706FD        cmp byte [0x697],0xfd	     ; Check for PCJr.
0000C8F1  7402              jz 0xc8f5
0000C8F3  D0E0              shl al,1
0000C8F5  A20E5B            mov [0x5b0e],al
0000C8F8  E832D9            call 0xa22d            ; Get a random number.
0000C8FB  80FA04            cmp dl,0x4
0000C8FE  7704              ja 0xc904
0000C900  FF060C5B          inc word [0x5b0c]
0000C904  F7060C5B0100      test word [0x5b0c],0x1
0000C90A  7405              jz 0xc911
0000C90C  83060A5B07        add word [0x5b0a],byte +0x7
0000C911  B0B6              mov al,0xb6
0000C913  E643              out 0x43,al
0000C915  E815D9            call 0xa22d            ; Get a random number.
0000C918  8BC2              mov ax,dx
0000C91A  23060A5B          and ax,[0x5b0a]
0000C91E  25FF01            and ax,0x1ff
0000C921  059001            add ax,0x190
0000C924  E89203            call 0xccb9
0000C927  C3                ret
0000C928  2AE4              sub ah,ah
0000C92A  CD1A              int 0x1a
0000C92C  803E205900        cmp byte [0x5920],0x0
0000C931  741F              jz 0xc952
0000C933  3B162159          cmp dx,[0x5921]
0000C937  7459              jz 0xc992
0000C939  89162159          mov [0x5921],dx
0000C93D  FE0E2059          dec byte [0x5920]
0000C941  740B              jz 0xc94e
0000C943  B0B6              mov al,0xb6
0000C945  E643              out 0x43,al
0000C947  A12359            mov ax,[0x5923]
0000C94A  E86C03            call 0xccb9
0000C94D  C3                ret

0000C94E  E80006            call 0xcf51		; Turn off the PC-Speaker.
0000C951  C3                ret

0000C952  3B162559          cmp dx,[0x5925]
0000C956  743A              jz 0xc992
0000C958  BE0300            mov si,0x3
0000C95B  A0BF1C            mov al,[0x1cbf]
0000C95E  0A06075B          or al,[0x5b07]
0000C962  7515              jnz 0xc979
0000C964  BE0100            mov si,0x1
0000C967  833E040000        cmp word [0x4],byte +0x0
0000C96C  750B              jnz 0xc979
0000C96E  4E                dec si
0000C96F  803E731600        cmp byte [0x1673],0x0
0000C974  7403              jz 0xc979
0000C976  BE0200            mov si,0x2
0000C979  8BFE              mov di,si
0000C97B  D1E7              shl di,1
0000C97D  A08405            mov al,[0x584]
0000C980  0A06075B          or al,[0x5b07]
0000C984  750D              jnz 0xc993
0000C986  8BC2              mov ax,dx
0000C988  2B062559          sub ax,[0x5925]
0000C98C  3B85F259          cmp ax,[di+0x59f2]
0000C990  7301              jnc 0xc993
0000C992  C3                ret
0000C993  89162559          mov [0x5925],dx
0000C997  803EBF1C00        cmp byte [0x1cbf],0x0
0000C99C  750B              jnz 0xc9a9
0000C99E  803E075B00        cmp byte [0x5b07],0x0
0000C9A3  7429              jz 0xc9ce
0000C9A5  FE0E075B          dec byte [0x5b07]
0000C9A9  C7062E590012      mov word [0x592e],0x1200
0000C9AF  8B1EBA59          mov bx,[0x59ba]
0000C9B3  83FB06            cmp bx,byte +0x6
0000C9B6  7206              jc 0xc9be
0000C9B8  2BDB              sub bx,bx
0000C9BA  891EBA59          mov [0x59ba],bx
0000C9BE  8306BA5902        add word [0x59ba],byte +0x2
0000C9C3  8B87445A          mov ax,[bx+0x5a44]
0000C9C7  A32A59            mov [0x592a],ax
0000C9CA  E88B05            call 0xcf58
0000C9CD  C3                ret
0000C9CE  83FE02            cmp si,byte +0x2
0000C9D1  7518              jnz 0xc9eb
0000C9D3  A07316            mov al,[0x1673]
0000C9D6  2AE4              sub ah,ah
0000C9D8  B104              mov cl,0x4
0000C9DA  D3E0              shl ax,cl
0000C9DC  050002            add ax,0x200
0000C9DF  A32A59            mov [0x592a],ax
0000C9E2  C7062E590018      mov word [0x592e],0x1800
0000C9E8  E9D200            jmp 0xcabd
0000C9EB  8B85025A          mov ax,[di+0x5a02]
0000C9EF  A32E59            mov [0x592e],ax
0000C9F2  D02E2759          shr byte [0x5927],1
0000C9F6  735B              jnc 0xca53
0000C9F8  C7062E590010      mov word [0x592e],0x1000
0000C9FE  C606275980        mov byte [0x5927],0x80
0000CA03  FE062859          inc byte [0x5928]
0000CA07  A02859            mov al,[0x5928]
0000CA0A  2284FA59          and al,[si+0x59fa]
0000CA0E  7536              jnz 0xca46
0000CA10  8A940A5A          mov dl,[si+0x5a0a]
0000CA14  00162959          add [0x5929],dl
0000CA18  E812D8            call 0xa22d            ; Get a random number.
0000CA1B  3A940C5A          cmp dl,[si+0x5a0c]
0000CA1F  7707              ja 0xca28
0000CA21  80E207            and dl,0x7
0000CA24  88162D59          mov [0x592d],dl
0000CA28  E802D8            call 0xa22d            ; Get a random number.
0000CA2B  81E2FF00          and dx,0xff
0000CA2F  D1E2              shl dx,1
0000CA31  B101              mov cl,0x1
0000CA33  F6C202            test dl,0x2
0000CA36  7406              jz 0xca3e
0000CA38  B1FF              mov cl,0xff
0000CA3A  81C20003          add dx,0x300
0000CA3E  89162A59          mov [0x592a],dx
0000CA42  880E2C59          mov [0x592c],cl
0000CA46  8A262959          mov ah,[0x5929]
0000CA4A  22A4FC59          and ah,[si+0x59fc]
0000CA4E  0AC4              or al,ah
0000CA50  A22859            mov [0x5928],al
0000CA53  803E2C59FF        cmp byte [0x592c],0xff
0000CA58  7416              jz 0xca70
0000CA5A  8306545A02        add word [0x5a54],byte +0x2
0000CA5F  8B1E545A          mov bx,[0x5a54]
0000CA63  81E30E00          and bx,0xe
0000CA67  8B87445A          mov ax,[bx+0x5a44]
0000CA6B  A32A59            mov [0x592a],ax
0000CA6E  EB13              jmp short 0xca83
0000CA70  813E2A59C800      cmp word [0x592a],0xc8
0000CA76  7706              ja 0xca7e
0000CA78  C7062A590005      mov word [0x592a],0x500
0000CA7E  832E2A5919        sub word [0x592a],byte +0x19
0000CA83  803E840500        cmp byte [0x584],0x0
0000CA88  740D              jz 0xca97
0000CA8A  C7062E590020      mov word [0x592e],0x2000
0000CA90  C6062C59FF        mov byte [0x592c],0xff
0000CA95  7526              jnz 0xcabd
0000CA97  8A1E2859          mov bl,[0x5928]
0000CA9B  2AFF              sub bh,bh
0000CA9D  039DFE59          add bx,[di+0x59fe]
0000CAA1  8A87C259          mov al,[bx+0x59c2]
0000CAA5  22062759          and al,[0x5927]
0000CAA9  7512              jnz 0xcabd
0000CAAB  803E2D5900        cmp byte [0x592d],0x0
0000CAB0  740E              jz 0xcac0
0000CAB2  FE0E2D59          dec byte [0x592d]
0000CAB6  8B85065A          mov ax,[di+0x5a06]
0000CABA  A32E59            mov [0x592e],ax
0000CABD  E89804            call 0xcf58
0000CAC0  C3                ret

0000CAC1  E88D04            call 0xcf51		        ; Turn off the PC-Speaker.
0000CAC4  B40B              mov ah,0xb			; Set a red background.
0000CAC6  BB0400            mov bx,0x4			;
0000CAC9  CD10              int 0x10			;
0000CACB  2AE4              sub ah,ah			; Get the system clock tick count.
0000CACD  CD1A              int 0x1a			;
0000CACF  8916E25A          mov [0x5ae2],dx		;
0000CAD3  C706E45A0000      mov word [0x5ae4],0x0
0000CAD9  B002              mov al,0x2
0000CADB  803E9706FD        cmp byte [0x697],0xfd	; Do PCJr stuff.
0000CAE0  7502              jnz 0xcae4			;
0000CAE2  D0E8              shr al,1			;
0000CAE4  A2065B            mov [0x5b06],al
0000CAE7  803E000000        cmp byte [0x0],0x0
0000CAEC  741A              jz 0xcb08
0000CAEE  FF06E45A          inc word [0x5ae4]
0000CAF2  8B1EE45A          mov bx,[0x5ae4]
0000CAF6  8A0E065B          mov cl,[0x5b06]
0000CAFA  D3EB              shr bx,cl
0000CAFC  81E31F00          and bx,0x1f
0000CB00  E461              in al,0x61
0000CB02  3287E65A          xor al,[bx+0x5ae6]
0000CB06  E661              out 0x61,al
0000CB08  2AE4              sub ah,ah
0000CB0A  CD1A              int 0x1a
0000CB0C  2B16E25A          sub dx,[0x5ae2]
0000CB10  83FA02            cmp dx,byte +0x2
0000CB13  72D2              jc 0xcae7
0000CB15  B40B              mov ah,0xb
0000CB17  2BDB              sub bx,bx
0000CB19  CD10              int 0x10
0000CB1B  C606075B0C        mov byte [0x5b07],0xc
0000CB20  E82E04            call 0xcf51		; Turn off the PC-Speaker.
0000CB23  C3                ret

0000CB24  B80002            mov ax,0x200
0000CB27  803E9706FD        cmp byte [0x697],0xfd	     ; Check for PCJr.
0000CB2C  7502              jnz 0xcb30
0000CB2E  D1E0              shl ax,1
0000CB30  A3D05A            mov [0x5ad0],ax
0000CB33  C3                ret

0000CB34  FF06D05A          inc word [0x5ad0]
0000CB38  8B1ED05A          mov bx,[0x5ad0]
0000CB3C  8BD3              mov dx,bx
0000CB3E  B109              mov cl,0x9
0000CB40  D3EA              shr dx,cl
0000CB42  8ACA              mov cl,dl
0000CB44  80E10F            and cl,0xf
0000CB47  D3EB              shr bx,cl
0000CB49  81E30F00          and bx,0xf
0000CB4D  8A97D25A          mov dl,[bx+0x5ad2]
0000CB51  22160000          and dl,[0x0]
0000CB55  E461              in al,0x61
0000CB57  24FC              and al,0xfc
0000CB59  0AC2              or al,dl
0000CB5B  E661              out 0x61,al
0000CB5D  C3                ret

0000CB5E  C706CB5AF401      mov word [0x5acb],0x1f4
0000CB64  E83700            call 0xcb9e
0000CB67  832ECB5A1E        sub word [0x5acb],byte +0x1e
0000CB6C  813ECB5AC800      cmp word [0x5acb],0xc8
0000CB72  77F0              ja 0xcb64
0000CB74  C706CB5AF401      mov word [0x5acb],0x1f4
0000CB7A  E82100            call 0xcb9e
0000CB7D  832ECB5A14        sub word [0x5acb],byte +0x14
0000CB82  813ECB5A2C01      cmp word [0x5acb],0x12c
0000CB88  77F0              ja 0xcb7a
0000CB8A  E81100            call 0xcb9e
0000CB8D  8306CB5A1E        add word [0x5acb],byte +0x1e
0000CB92  813ECB5A2003      cmp word [0x5acb],0x320
0000CB98  72F0              jc 0xcb8a
0000CB9A  E8B403            call 0xcf51		; Turn off the PC-Speaker.
0000CB9D  C3                ret

0000CB9E  B90010            mov cx,0x1000
0000CBA1  803E9706FD        cmp byte [0x697],0xfd	     ; Check for PCJr.
0000CBA6  7502              jnz 0xcbaa
0000CBA8  D1E9              shr cx,1
0000CBAA  E2FE              loop 0xcbaa
0000CBAC  803E000000        cmp byte [0x0],0x0
0000CBB1  7413              jz 0xcbc6
0000CBB3  B0B6              mov al,0xb6
0000CBB5  E643              out 0x43,al
0000CBB7  A1CB5A            mov ax,[0x5acb]
0000CBBA  E642              out 0x42,al
0000CBBC  8AC4              mov al,ah
0000CBBE  E642              out 0x42,al
0000CBC0  E461              in al,0x61
0000CBC2  0C03              or al,0x3
0000CBC4  E661              out 0x61,al
0000CBC6  C3                ret

0000CBC7  E88703            call 0xcf51		; Turn off the PC-Speaker.
0000CBCA  C606CF5A00        mov byte [0x5acf],0x0
0000CBCF  C706CD5A0800      mov word [0x5acd],0x8
0000CBD5  C3                ret

0000CBD6  FE06CF5A          inc byte [0x5acf]
0000CBDA  2AD2              sub dl,dl
0000CBDC  A0CF5A            mov al,[0x5acf]
0000CBDF  243F              and al,0x3f
0000CBE1  7504              jnz 0xcbe7
0000CBE3  FF06CD5A          inc word [0x5acd]
0000CBE7  8B1ECD5A          mov bx,[0x5acd]
0000CBEB  B102              mov cl,0x2
0000CBED  D3EB              shr bx,cl
0000CBEF  80E31F            and bl,0x1f
0000CBF2  3AC3              cmp al,bl
0000CBF4  7202              jc 0xcbf8
0000CBF6  B202              mov dl,0x2
0000CBF8  22160000          and dl,[0x0]
0000CBFC  E461              in al,0x61
0000CBFE  24FD              and al,0xfd
0000CC00  0AC2              or al,dl
0000CC02  E661              out 0x61,al
0000CC04  C3                ret

0000CC05  C706855A0000      mov word [0x5a85],0x0
0000CC0B  2AE4              sub ah,ah
0000CC0D  CD1A              int 0x1a
0000CC0F  8916835A          mov [0x5a83],dx
0000CC13  C3                ret

0000CC14  803E000000        cmp byte [0x0],0x0
0000CC19  743D              jz 0xcc58
0000CC1B  2AE4              sub ah,ah
0000CC1D  CD1A              int 0x1a
0000CC1F  8BC2              mov ax,dx
0000CC21  2B06835A          sub ax,[0x5a83]
0000CC25  3D0200            cmp ax,0x2
0000CC28  722E              jc 0xcc58
0000CC2A  8916835A          mov [0x5a83],dx
0000CC2E  8B1E855A          mov bx,[0x5a85]
0000CC32  8306855A02        add word [0x5a85],byte +0x2
0000CC37  803E520500        cmp byte [0x552],0x0
0000CC3C  740D              jz 0xcc4b
0000CC3E  8B87A35A          mov ax,[bx+0x5aa3]
0000CC42  3D0000            cmp ax,0x0
0000CC45  7508              jnz 0xcc4f
0000CC47  E80703            call 0xcf51		; Turn off the PC-Speaker.
0000CC4A  C3                ret
0000CC4B  8B87875A          mov ax,[bx+0x5a87]
0000CC4F  50                push ax
0000CC50  B0B6              mov al,0xb6
0000CC52  E643              out 0x43,al
0000CC54  58                pop ax
0000CC55  E86100            call 0xccb9
0000CC58  C3                ret
0000CC59  C706625A0000      mov word [0x5a62],0x0
0000CC5F  C606825A00        mov byte [0x5a82],0x0
0000CC64  C3                ret
0000CC65  803E000000        cmp byte [0x0],0x0
0000CC6A  740A              jz 0xcc76
0000CC6C  2AE4              sub ah,ah
0000CC6E  CD1A              int 0x1a
0000CC70  3B16805A          cmp dx,[0x5a80]
0000CC74  7501              jnz 0xcc77
0000CC76  C3                ret
0000CC77  8916805A          mov [0x5a80],dx
0000CC7B  FE06825A          inc byte [0x5a82]
0000CC7F  B0B6              mov al,0xb6
0000CC81  E643              out 0x43,al
0000CC83  8B1E625A          mov bx,[0x5a62]
0000CC87  F606825A01        test byte [0x5a82],0x1
0000CC8C  7503              jnz 0xcc91
0000CC8E  83C302            add bx,byte +0x2
0000CC91  8B87645A          mov ax,[bx+0x5a64]
0000CC95  E82100            call 0xccb9
0000CC98  C3                ret
0000CC99  803E000000        cmp byte [0x0],0x0
0000CC9E  7418              jz 0xccb8
0000CCA0  53                push bx
0000CCA1  50                push ax
0000CCA2  B0B6              mov al,0xb6
0000CCA4  E643              out 0x43,al
0000CCA6  8B1E625A          mov bx,[0x5a62]
0000CCAA  8306625A02        add word [0x5a62],byte +0x2
0000CCAF  8B87645A          mov ax,[bx+0x5a64]
0000CCB3  E80300            call 0xccb9
0000CCB6  58                pop ax
0000CCB7  5B                pop bx
0000CCB8  C3                ret
0000CCB9  E642              out 0x42,al
0000CCBB  8AC4              mov al,ah
0000CCBD  E642              out 0x42,al
0000CCBF  E461              in al,0x61
0000CCC1  0C03              or al,0x3
0000CCC3  E661              out 0x61,al
0000CCC5  C3                ret
0000CCC6  C3                ret
0000CCC7  803E000000        cmp byte [0x0],0x0
0000CCCC  741E              jz 0xccec
0000CCCE  50                push ax
0000CCCF  51                push cx
0000CCD0  52                push dx
0000CCD1  B0B6              mov al,0xb6
0000CCD3  E643              out 0x43,al
0000CCD5  8B1E565A          mov bx,[0x5a56]
0000CCD9  81E30600          and bx,0x6
0000CCDD  8306565A02        add word [0x5a56],byte +0x2
0000CCE2  8B875A5A          mov ax,[bx+0x5a5a]
0000CCE6  E8D0FF            call 0xccb9
0000CCE9  5A                pop dx
0000CCEA  59                pop cx
0000CCEB  58                pop ax
0000CCEC  C3                ret

0000CCED  C606275980        mov byte [0x5927],0x80
0000CCF2  C606285900        mov byte [0x5928],0x0
0000CCF7  C606295900        mov byte [0x5929],0x0
0000CCFC  C7062A590005      mov word [0x592a],0x500
0000CD02  C6062C59FF        mov byte [0x592c],0xff
0000CD07  C6062D5900        mov byte [0x592d],0x0
0000CD0C  C606205900        mov byte [0x5920],0x0
0000CD11  C606075B00        mov byte [0x5b07],0x0
0000CD16  C706085B0000      mov word [0x5b08],0x0
0000CD1C  C7060C5B0100      mov word [0x5b0c],0x1
0000CD22  C6060E5B01        mov byte [0x5b0e],0x1
0000CD27  C3                ret

0000CD28  803EBF1C00        cmp byte [0x1cbf],0x0
0000CD2D  7509              jnz 0xcd38
0000CD2F  BB9003            mov bx,0x390
0000CD32  B90018            mov cx,0x1800
0000CD35  E89B00            call 0xcdd3
0000CD38  C6067C1200        mov byte [0x127c],0x0
0000CD3D  C3                ret

0000CD3E  803EBF1C00        cmp byte [0x1cbf],0x0
0000CD43  7509              jnz 0xcd4e
0000CD45  BB0004            mov bx,0x400
0000CD48  B90018            mov cx,0x1800
0000CD4B  E88500            call 0xcdd3
0000CD4E  C3                ret
0000CD4F  BBD007            mov bx,0x7d0
0000CD52  B90018            mov cx,0x1800
0000CD55  E87B00            call 0xcdd3
0000CD58  BB6E0A            mov bx,0xa6e
0000CD5B  B90018            mov cx,0x1800
0000CD5E  E87200            call 0xcdd3
0000CD61  BBEC0D            mov bx,0xdec
0000CD64  B90018            mov cx,0x1800
0000CD67  E86900            call 0xcdd3
0000CD6A  C3                ret
0000CD6B  803E000000        cmp byte [0x0],0x0
0000CD70  741A              jz 0xcd8c
0000CD72  891E2359          mov [0x5923],bx
0000CD76  50                push ax
0000CD77  B0B6              mov al,0xb6
0000CD79  E643              out 0x43,al
0000CD7B  58                pop ax
0000CD7C  E83AFF            call 0xccb9
0000CD7F  C606205902        mov byte [0x5920],0x2
0000CD84  2AE4              sub ah,ah
0000CD86  CD1A              int 0x1a
0000CD88  89162159          mov [0x5921],dx
0000CD8C  C3                ret

0000CD8D  803E000000        cmp byte [0x0],0x0
0000CD92  741A              jz 0xcdae
0000CD94  803E205900        cmp byte [0x5920],0x0
0000CD99  7513              jnz 0xcdae
0000CD9B  E88FD4            call 0xa22d            ; Get a random number.
0000CD9E  8BC2              mov ax,dx
0000CDA0  257F00            and ax,0x7f
0000CDA3  05AA00            add ax,0xaa
0000CDA6  8BD8              mov bx,ax
0000CDA8  051E00            add ax,0x1e
0000CDAB  E8BDFF            call 0xcd6b
0000CDAE  C3                ret

0000CDAF  803E000000        cmp byte [0x0],0x0
0000CDB4  741C              jz 0xcdd2
0000CDB6  B80012            mov ax,0x1200
0000CDB9  BB1213            mov bx,0x1312
0000CDBC  0306085B          add ax,[0x5b08]
0000CDC0  031E085B          add bx,[0x5b08]
0000CDC4  8106085B5E01      add word [0x5b08],0x15e
0000CDCA  E89EFF            call 0xcd6b
0000CDCD  C606075B18        mov byte [0x5b07],0x18
0000CDD2  C3                ret

0000CDD3  803E000000        cmp byte [0x0],0x0
0000CDD8  7420              jz 0xcdfa
0000CDDA  B0B6              mov al,0xb6
0000CDDC  E643              out 0x43,al
0000CDDE  8BC3              mov ax,bx
0000CDE0  E642              out 0x42,al
0000CDE2  8AC4              mov al,ah
0000CDE4  E642              out 0x42,al
0000CDE6  E461              in al,0x61
0000CDE8  0C03              or al,0x3
0000CDEA  E661              out 0x61,al
0000CDEC  803E9706FD        cmp byte [0x697],0xfd	     ; Check for PCJr.
0000CDF1  7502              jnz 0xcdf5
0000CDF3  D1E9              shr cx,1
0000CDF5  E2FE              loop 0xcdf5
0000CDF7  E85701            call 0xcf51		             ; Turn off the PC-Speaker.
0000CDFA  C3                ret
0000CDFB  E461              in al,0x61
0000CDFD  24FE              and al,0xfe
0000CDFF  E661              out 0x61,al
0000CE01  2AE4              sub ah,ah
0000CE03  CD1A              int 0x1a
0000CE05  8916405A          mov [0x5a40],dx
0000CE09  C706425A0000      mov word [0x5a42],0x0
0000CE0F  A1425A            mov ax,[0x5a42]
0000CE12  B106              mov cl,0x6
0000CE14  D3E8              shr ax,cl
0000CE16  7501              jnz 0xce19
0000CE18  40                inc ax
0000CE19  8BC8              mov cx,ax
0000CE1B  51                push cx
0000CE1C  2AE4              sub ah,ah
0000CE1E  CD1A              int 0x1a
0000CE20  59                pop cx
0000CE21  2B16405A          sub dx,[0x5a40]
0000CE25  83FA02            cmp dx,byte +0x2
0000CE28  72F1              jc 0xce1b
0000CE2A  83FA07            cmp dx,byte +0x7
0000CE2D  7319              jnc 0xce48
0000CE2F  E2EA              loop 0xce1b
0000CE31  E8F9D3            call 0xa22d            ; Get a random number.
0000CE34  80E202            and dl,0x2
0000CE37  22160000          and dl,[0x0]
0000CE3B  E461              in al,0x61
0000CE3D  32C2              xor al,dl
0000CE3F  E661              out 0x61,al
0000CE41  8306425A07        add word [0x5a42],byte +0x7
0000CE46  EBC7              jmp short 0xce0f
0000CE48  E80601            call 0xcf51	           ; Turn off the PC-Speaker.
0000CE4B  C3                ret
0000CE4C  803E000000        cmp byte [0x0],0x0
0000CE51  7411              jz 0xce64
0000CE53  E891B9            call 0x87e7
0000CE56  8B1E165A          mov bx,[0x5a16]
0000CE5A  2BD8              sub bx,ax
0000CE5C  7207              jc 0xce65
0000CE5E  81FB6002          cmp bx,0x260
0000CE62  7701              ja 0xce65
0000CE64  C3                ret

0000CE65  A3165A            mov [0x5a16],ax
0000CE68  B0B6              mov al,0xb6
0000CE6A  E643              out 0x43,al
0000CE6C  FF06185A          inc word [0x5a18]
0000CE70  8B1E185A          mov bx,[0x5a18]
0000CE74  81E31E00          and bx,0x1e
0000CE78  A13C5A            mov ax,[0x5a3c]
0000CE7B  25FF03            and ax,0x3ff
0000CE7E  3D8001            cmp ax,0x180
0000CE81  7206              jc 0xce89
0000CE83  B98001            mov cx,0x180
0000CE86  2BC8              sub cx,ax
0000CE88  91                xchg ax,cx
0000CE89  D1E8              shr ax,1
0000CE8B  D1E8              shr ax,1
0000CE8D  03871A5A          add ax,[bx+0x5a1a]
0000CE91  BB0100            mov bx,0x1
0000CE94  803E9706FD        cmp byte [0x697],0xfd	     ; Check for PCJr.
0000CE99  7502              jnz 0xce9d
0000CE9B  D0E3              shl bl,1
0000CE9D  011E3E5A          add [0x5a3e],bx
0000CEA1  D1E3              shl bx,1
0000CEA3  D1E3              shl bx,1
0000CEA5  011E3C5A          add [0x5a3c],bx
0000CEA9  8B163E5A          mov dx,[0x5a3e]
0000CEAD  B103              mov cl,0x3
0000CEAF  D3EA              shr dx,cl
0000CEB1  03C2              add ax,dx
0000CEB3  E642              out 0x42,al
0000CEB5  8AC4              mov al,ah
0000CEB7  E642              out 0x42,al
0000CEB9  E461              in al,0x61
0000CEBB  0C03              or al,0x3
0000CEBD  E661              out 0x61,al
0000CEBF  C3                ret

0000CEC0  803E000000        cmp byte [0x0],0x0
0000CEC5  740A              jz 0xced1
0000CEC7  2AE4              sub ah,ah
0000CEC9  CD1A              int 0x1a
0000CECB  3B16145A          cmp dx,[0x5a14]
0000CECF  7501              jnz 0xced2
0000CED1  C3                ret

0000CED2  8916145A          mov [0x5a14],dx
0000CED6  B0B6              mov al,0xb6
0000CED8  E643              out 0x43,al
0000CEDA  E850D3            call 0xa22d            ; Get a random number.
0000CEDD  8BC2              mov ax,dx
0000CEDF  257000            and ax,0x70
0000CEE2  050002            add ax,0x200
0000CEE5  E642              out 0x42,al
0000CEE7  8AC4              mov al,ah
0000CEE9  E642              out 0x42,al
0000CEEB  E461              in al,0x61
0000CEED  0C03              or al,0x3
0000CEEF  E661              out 0x61,al
0000CEF1  C3                ret
0000CEF2  C706125A3803      mov word [0x5a12],0x338
0000CEF8  2AE4              sub ah,ah
0000CEFA  CD1A              int 0x1a
0000CEFC  8916105A          mov [0x5a10],dx
0000CF00  E8E4B8            call 0x87e7
0000CF03  A30E5A            mov [0x5a0e],ax
0000CF06  E8DEB8            call 0x87e7
0000CF09  8BD0              mov dx,ax
0000CF0B  2B060E5A          sub ax,[0x5a0e]
0000CF0F  3D409C            cmp ax,0x9c40
0000CF12  722C              jc 0xcf40
0000CF14  89160E5A          mov [0x5a0e],dx
0000CF18  803E000000        cmp byte [0x0],0x0
0000CF1D  7421              jz 0xcf40
0000CF1F  B0B6              mov al,0xb6
0000CF21  E643              out 0x43,al
0000CF23  E807D3            call 0xa22d            ; Get a random number.
0000CF26  8BC2              mov ax,dx
0000CF28  25FF07            and ax,0x7ff
0000CF2B  0306125A          add ax,[0x5a12]
0000CF2F  832E125A02        sub word [0x5a12],byte +0x2
0000CF34  E642              out 0x42,al
0000CF36  8AC4              mov al,ah
0000CF38  E642              out 0x42,al
0000CF3A  E461              in al,0x61
0000CF3C  0C03              or al,0x3
0000CF3E  E661              out 0x61,al
0000CF40  2AE4              sub ah,ah
0000CF42  CD1A              int 0x1a
0000CF44  2B16105A          sub dx,[0x5a10]
0000CF48  83FA02            cmp dx,byte +0x2
0000CF4B  72B9              jc 0xcf06
0000CF4D  E80100            call 0xcf51		; Turn off the PC-Speaker.
0000CF50  C3                ret

; Turns of the PC-Speaker.
0000CF51  E461              in al,0x61
0000CF53  24FC              and al,0xfc
0000CF55  E661              out 0x61,al
0000CF57  C3                ret

0000CF58  B0B6              mov al,0xb6
0000CF5A  E643              out 0x43,al
0000CF5C  A12A59            mov ax,[0x592a]
0000CF5F  E642              out 0x42,al
0000CF61  8AC4              mov al,ah
0000CF63  E642              out 0x42,al
0000CF65  E461              in al,0x61
0000CF67  0C03              or al,0x3
0000CF69  E661              out 0x61,al
0000CF6B  E879B8            call 0x87e7
0000CF6E  8BC8              mov cx,ax
0000CF70  E874B8            call 0x87e7
0000CF73  8BD1              mov dx,cx
0000CF75  2BD0              sub dx,ax
0000CF77  3B162E59          cmp dx,[0x592e]
0000CF7B  72F3              jc 0xcf70
0000CF7D  E461              in al,0x61
0000CF7F  24FC              and al,0xfc
0000CF81  E661              out 0x61,al
0000CF83  C3                ret
0000CF84  C706BE590000      mov word [0x59be],0x0
0000CF8A  2AE4              sub ah,ah
0000CF8C  CD1A              int 0x1a
0000CF8E  8916C059          mov [0x59c0],dx
0000CF92  C3                ret
0000CF93  803E000000        cmp byte [0x0],0x0
0000CF98  740F              jz 0xcfa9
0000CF9A  2AE4              sub ah,ah
0000CF9C  CD1A              int 0x1a
0000CF9E  8BC2              mov ax,dx
0000CFA0  2B06C059          sub ax,[0x59c0]
0000CFA4  3D0200            cmp ax,0x2
0000CFA7  7301              jnc 0xcfaa
0000CFA9  C3                ret
0000CFAA  8916C059          mov [0x59c0],dx
0000CFAE  8B1EBE59          mov bx,[0x59be]
0000CFB2  81E3FE00          and bx,0xfe
0000CFB6  81FB8600          cmp bx,0x86
0000CFBA  7206              jc 0xcfc2
0000CFBC  2BDB              sub bx,bx
0000CFBE  891EBE59          mov [0x59be],bx
0000CFC2  8306BE5902        add word [0x59be],byte +0x2
0000CFC7  8B873459          mov ax,[bx+0x5934]
0000CFCB  8B0EBC59          mov cx,[0x59bc]
0000CFCF  A3BC59            mov [0x59bc],ax
0000CFD2  3BC1              cmp ax,cx
0000CFD4  7504              jnz 0xcfda
0000CFD6  E878FF            call 0xcf51		; Turn off the PC-Speaker.
0000CFD9  C3                ret

0000CFDA  8BC8              mov cx,ax
0000CFDC  B0B6              mov al,0xb6
0000CFDE  E643              out 0x43,al
0000CFE0  8BC1              mov ax,cx
0000CFE2  E642              out 0x42,al
0000CFE4  8AC4              mov al,ah
0000CFE6  E642              out 0x42,al
0000CFE8  E461              in al,0x61
0000CFEA  0C03              or al,0x3
0000CFEC  E661              out 0x61,al
0000CFEE  C3                ret
0000CFEF  803E000000        cmp byte [0x0],0x0
0000CFF4  740A              jz 0xd000
0000CFF6  E89AFF            call 0xcf93
0000CFF9  833EBE597C        cmp word [0x59be],byte +0x7c
0000CFFE  72EF              jc 0xcfef
0000D000  C3                ret

0000D001  0000              add [bx+si],al
0000D003  0000              add [bx+si],al
0000D005  0000              add [bx+si],al
0000D007  0000              add [bx+si],al
0000D009  0000              add [bx+si],al
0000D00B  0000              add [bx+si],al
0000D00D  0000              add [bx+si],al
0000D00F  002A              add [bp+si],ch
0000D011  E4CD              in al,0xcd
0000D013  1A891666          sbb cl,[bx+di+0x6616]
0000D017  5F                pop di
0000D018  C706605F0000      mov word [0x5f60],0x0
0000D01E  B800B8            mov ax,0xb800		; Draws the sprite.
0000D021  8EC0              mov es,ax			;
0000D023  8B1E605F          mov bx,[0x5f60]		;
0000D027  8306605F02        add word [0x5f60],byte +0x2	;
0000D02C  81E30200          and bx,0x2			;
0000D030  8BB7625F          mov si,[bx+0x5f62]		;
0000D034  BF740A            mov di,0xa74		;
0000D037  B90444            mov cx,0x4404		;
0000D03A  E890D1            call 0xa1cd                	;
0000D03D  E8D4FB            call 0xcc14
0000D040  2AE4              sub ah,ah
0000D042  CD1A              int 0x1a
0000D044  8BC2              mov ax,dx
0000D046  2B06665F          sub ax,[0x5f66]
0000D04A  3D0400            cmp ax,0x4
0000D04D  72EE              jc 0xd03d
0000D04F  8916665F          mov [0x5f66],dx
0000D053  833E605F04        cmp word [0x5f60],byte +0x4
0000D058  750C              jnz 0xd066
0000D05A  BE685F            mov si,0x5f68		; Draws the sprite.
0000D05D  BF6806            mov di,0x668		;
0000D060  B90410            mov cx,0x1004		;
0000D063  E867D1            call 0xa1cd                 ;
0000D066  8B1E605F          mov bx,[0x5f60]
0000D06A  83EB08            sub bx,byte +0x8
0000D06D  7212              jc 0xd081
0000D06F  83FB06            cmp bx,byte +0x6
0000D072  730D              jnc 0xd081
0000D074  BEE85F            mov si,0x5fe8		; Draws the sprite.
0000D077  8BBFE460          mov di,[bx+0x60e4]		;
0000D07B  B90615            mov cx,0x1506		;
0000D07E  E84CD1            call 0xa1cd                 ;
0000D081  833E605F10        cmp word [0x5f60],byte +0x10
0000D086  7296              jc 0xd01e
0000D088  E8C6FE            call 0xcf51		; Turn off the PC-Speaker.
0000D08B  C3                ret

0000D090  CD11              int 0x11       ; Check whether the initial video mode was set to MDA/Hercules.
0000D092  2430              and al,0x30    ;
0000D094  3C30              cmp al,0x30    ;
0000D096  752D              jnz 0xd0c5     ;
0000D098  B800B8            mov ax,0xb800  ; Select text mode buffer.
0000D09B  8ED8              mov ds,ax      ;
0000D09D  B8AA55            mov ax,0x55aa  ; Test memory.
0000D0A0  A30000            mov [0x0],ax   ;
0000D0A3  A10000            mov ax,[0x0]   ;
0000D0A6  3DAA55            cmp ax,0x55aa  ;
0000D0A9  751B              jnz 0xd0c6     ;
0000D0AB  BEF060            mov si,0x60f0  ; Pointer to "turn on color monitor".
0000D0AE  E81D00            call 0xd0ce    ; Select program data segment and print string.
0000D0B1  B84000            mov ax,0x40    ; Modify the equipment flag list to specify 40x25 16 color text as the initial video mode.
0000D0B4  8ED8              mov ds,ax      ;
0000D0B6  A11000            mov ax,[0x10]  ;
0000D0B9  24CF              and al,0xcf    ;
0000D0BB  0C10              or al,0x10     ;
0000D0BD  A31000            mov [0x10],ax  ;
0000D0C0  B80400            mov ax,0x4     ; Select CGA video mode.
0000D0C3  CD10              int 0x10       ;
0000D0C5  C3                ret            ;

0000D0C6  BE1261            mov si,0x6112      ; Pointer to "color monitor required.
0000D0C9  E80200            call 0xd0ce        ; Select program data segment and print string.
0000D0CC  EBFE              jmp short 0xd0cc   ;

0000D0CE  B81000            mov ax,0x10      ; Select program data segment.
0000D0D1  8ED8              mov ds,ax        ;
0000D0D3  E88501            call 0xd25b      ; Print string.
0000D0D6  C3                ret              ;

0000D0E0  FC                cld
0000D0E1  C70604000000      mov word [0x4],0x0
0000D0E7  E876BB            call 0x8c60			; TO BE INVESTIGATED.
0000D0EA  E873C6            call 0x9760			; TO BE INVESTIGATED.
0000D0ED  E870CD            call 0x9e60			; Draw the fence.
0000D0F0  B800B8            mov ax,0xb800		; Draws the sprite.
0000D0F3  8EC0              mov es,ax			;
0000D0F5  BE5261            mov si,0x6152		;
0000D0F8  B90B1D            mov cx,0x1d0b		;
0000D0FB  BFBD00            mov di,0xbd			;
0000D0FE  E8CCD0            call 0xa1cd     		;
0000D101  BED063            mov si,0x63d0		; Draws the Alley Cat TM sprite.
0000D104  B90E16            mov cx,0x160e		;
0000D107  BF9E06            mov di,0x69e		;
0000D10A  E8C0D0            call 0xa1cd			;
0000D10D  BE3866            mov si,0x6638		; Draws the sprite.
0000D110  B9030C            mov cx,0xc03		;
0000D113  BF780A            mov di,0xa78		;
0000D116  E8B4D0            call 0xa1cd         	;
0000D119  BE8066            mov si,0x6680		; Draws the sprite.
0000D11C  B90E08            mov cx,0x80e		;
0000D11F  BFA80C            mov di,0xca8		;
0000D122  E8A8D0            call 0xa1cd         	;
0000D125  BE6067            mov si,0x6760		; Draws the sprite.
0000D128  B90C0B            mov cx,0xb0c		;
0000D12B  BF6E1D            mov di,0x1d6e		;
0000D12E  E89CD0            call 0xa1cd         	;
0000D131  BE6868            mov si,0x6868		; Draws the sprite.
0000D134  B90408            mov cx,0x804		;
0000D137  BFEC1D            mov di,0x1dec		;
0000D13A  E890D0            call 0xa1cd         	;
0000D13D  C7068D6A0000      mov word [0x6a8d],0x0
0000D143  E82501            call 0xd26b
0000D146  C70679050000      mov word [0x579],0x0
0000D14C  E8EEA9            call 0x7b3d
0000D14F  C6067B0560        mov byte [0x57b],0x60
0000D154  C6067C0592        mov byte [0x57c],0x92
0000D159  E8C6C9            call 0x9b22
0000D15C  E8CDC9            call 0x9b2c
0000D15F  C606801F09        mov byte [0x1f80],0x9	; Nine lives cheat?
0000D164  C606811FFF        mov byte [0x1f81],0xff
0000D169  E877C9            call 0x9ae3
0000D16C  E801C1            call 0x9270
0000D16F  C606980600        mov byte [0x698],0x0
0000D174  C606990600        mov byte [0x699],0x0
0000D179  C6068A6A00        mov byte [0x6a8a],0x0
0000D17E  A19306            mov ax,[0x693]
0000D181  A35061            mov [0x6150],ax
0000D184  2AE4              sub ah,ah
0000D186  CD1A              int 0x1a
0000D188  89168B6A          mov [0x6a8b],dx
0000D18C  89162253          mov [0x5322],dx
0000D190  8916936A          mov [0x6a93],dx
0000D194  83EA30            sub dx,byte +0x30
0000D197  8916886A          mov [0x6a88],dx
0000D19B  C70620530000      mov word [0x5320],0x0
0000D1A1  2AE4              sub ah,ah
0000D1A3  CD1A              int 0x1a
0000D1A5  8BC2              mov ax,dx
0000D1A7  2B06936A          sub ax,[0x6a93]
0000D1AB  3D2400            cmp ax,0x24
0000D1AE  7209              jc 0xd1b9
0000D1B0  8916936A          mov [0x6a93],dx
0000D1B4  52                push dx
0000D1B5  E8B300            call 0xd26b
0000D1B8  5A                pop dx
0000D1B9  2B168B6A          sub dx,[0x6a8b]
0000D1BD  A1DA56            mov ax,[0x56da]
0000D1C0  803E1A0400        cmp byte [0x41a],0x0
0000D1C5  7409              jz 0xd1d0
0000D1C7  054800            add ax,0x48
0000D1CA  3BD0              cmp dx,ax
0000D1CC  73B6              jnc 0xd184
0000D1CE  EB07              jmp short 0xd1d7
0000D1D0  050600            add ax,0x6
0000D1D3  3BD0              cmp dx,ax
0000D1D5  772C              ja 0xd203
0000D1D7  E806F6            call 0xc7e0
0000D1DA  E82700            call 0xd204
0000D1DD  803E9B0600        cmp byte [0x69b],0x0
0000D1E2  7416              jz 0xd1fa
0000D1E4  BA0102            mov dx,0x201
0000D1E7  EC                in al,dx
0000D1E8  2410              and al,0x10
0000D1EA  7407              jz 0xd1f3
0000D1EC  C6068A6A01        mov byte [0x6a8a],0x1
0000D1F1  EB07              jmp short 0xd1fa
0000D1F3  803E8A6A00        cmp byte [0x6a8a],0x0
0000D1F8  7509              jnz 0xd203
0000D1FA  A15061            mov ax,[0x6150]
0000D1FD  3B069306          cmp ax,[0x693]
0000D201  749E              jz 0xd1a1
0000D203  C3                ret

0000D204  833E790520        cmp word [0x579],byte +0x20
0000D209  7707              ja 0xd212
0000D20B  C606980601        mov byte [0x698],0x1
0000D210  EB3A              jmp short 0xd24c
0000D212  813E79052001      cmp word [0x579],0x120
0000D218  7207              jc 0xd221
0000D21A  C6069806FF        mov byte [0x698],0xff
0000D21F  EB2B              jmp short 0xd24c
0000D221  2AE4              sub ah,ah
0000D223  CD1A              int 0x1a
0000D225  8BC2              mov ax,dx
0000D227  2B06886A          sub ax,[0x6a88]
0000D22B  3D1200            cmp ax,0x12
0000D22E  721C              jc 0xd24c
0000D230  8916886A          mov [0x6a88],dx
0000D234  E8F6CF            call 0xa22d            ; Get a random number.
0000D237  C606980600        mov byte [0x698],0x0
0000D23C  80FAA0            cmp dl,0xa0
0000D23F  770B              ja 0xd24c
0000D241  80E201            and dl,0x1
0000D244  7502              jnz 0xd248
0000D246  B2FF              mov dl,0xff
0000D248  88169806          mov [0x698],dl
0000D24C  E8B9B5            call 0x8808   ; Get vertical retrace status.
0000D24F  7409              jz 0xd25a
0000D251  C70672050400      mov word [0x572],0x4
0000D257  E8BBAA            call 0x7d15
0000D25A  C3                ret

0000D25B  AC                lodsb                ; Print null-terminated string.
0000D25C  3C00              cmp al,0x0           ;
0000D25E  740A              jz 0xd26a            ;
0000D260  56                push si              ;
0000D261  B302              mov bl,0x2           ;
0000D263  B40E              mov ah,0xe           ;
0000D265  CD10              int 0x10             ;
0000D267  5E                pop si               ;
0000D268  EBF1              jmp short 0xd25b     ;
0000D26A  C3                ret                  ;

0000D26B  B800B8            mov ax,0xb800		; Draws the sprite.
0000D26E  8EC0              mov es,ax			;
0000D270  83068D6A02        add word [0x6a8d],byte +0x2	;
0000D275  8B1E8D6A          mov bx,[0x6a8d]		;
0000D279  81E30200          and bx,0x2			;
0000D27D  8BB78F6A          mov si,[bx+0x6a8f]		;
0000D281  B90A0C            mov cx,0xc0a		;
0000D284  BF381D            mov di,0x1d38		;
0000D287  E843CF            call 0xa1cd                 ;
0000D28A  C3                ret

0000D28B  B200              mov dl,0x0      ; Move cursor to upper-left corner.
0000D28D  8AFA              mov bh,dl       ;
0000D28F  B402              mov ah,0x2      ;
0000D291  CD10              int 0x10        ;
0000D293  C3                ret             ;

0000D2A0  E8AEFC            call 0xcf51	    	; Turn off the PC-Speaker.
0000D2A3  2AE4              sub ah,ah       	; Get system clock tick count.
0000D2A5  CD1A              int 0x1a        	;
0000D2A7  8916FC6D          mov [0x6dfc],dx 	;
0000D2AB  890EFE6D          mov [0x6dfe],cx	;
0000D2AF  1E                push ds
0000D2B0  1E                push ds
0000D2B1  07                pop es
0000D2B2  B800B8            mov ax,0xb800
0000D2B5  8ED8              mov ds,ax
0000D2B7  BECA0D            mov si,0xdca
0000D2BA  BF0E00            mov di,0xe
0000D2BD  B92010            mov cx,0x1020
0000D2C0  E837CF            call 0xa1fa
0000D2C3  1F                pop ds
0000D2C4  BA050B            mov dx,0xb05
0000D2C7  B700              mov bh,0x0
0000D2C9  B402              mov ah,0x2
0000D2CB  CD10              int 0x10
0000D2CD  BE916D            mov si,0x6d91
0000D2D0  FC                cld
0000D2D1  E887FF            call 0xd25b
0000D2D4  BA050C            mov dx,0xc05
0000D2D7  B700              mov bh,0x0
0000D2D9  B402              mov ah,0x2
0000D2DB  CD10              int 0x10
0000D2DD  BEB26D            mov si,0x6db2
0000D2E0  803E9B0600        cmp byte [0x69b],0x0
0000D2E5  7403              jz 0xd2ea
0000D2E7  BED36D            mov si,0x6dd3
0000D2EA  FC                cld
0000D2EB  E86DFF            call 0xd25b
0000D2EE  E8D600            call 0xd3c7
0000D2F1  B800B8            mov ax,0xb800       ; Draws the sprite.
0000D2F4  8EC0              mov es,ax		;
0000D2F6  BE0E00            mov si,0xe		;
0000D2F9  BFCA0D            mov di,0xdca	;
0000D2FC  B92010            mov cx,0x1020	;
0000D2FF  E8CBCE            call 0xa1cd		;
0000D302  B401              mov ah,0x1
0000D304  8B0EFE6D          mov cx,[0x6dfe]
0000D308  8B16FC6D          mov dx,[0x6dfc]
0000D30C  CD1A              int 0x1a
0000D30E  A19306            mov ax,[0x693]
0000D311  A3006E            mov [0x6e00],ax
0000D314  C3                ret

0000D315  E839FC            call 0xcf51		; Turn off the PC-Speaker.
0000D318  E8E200            call 0xd3fd
0000D31B  C7068F6D0000      mov word [0x6d8f],0x0
0000D321  E8BD00            call 0xd3e1
0000D324  A19306            mov ax,[0x693]
0000D327  3B069306          cmp ax,[0x693]
0000D32B  74FA              jz 0xd327
0000D32D  F606C10680        test byte [0x6c1],0x80
0000D332  740E              jz 0xd342
0000D334  F606C20680        test byte [0x6c2],0x80
0000D339  75E9              jnz 0xd324
0000D33B  C6069B0600        mov byte [0x69b],0x0
0000D340  EB0A              jmp short 0xd34c
0000D342  E8D000            call 0xd415
0000D345  72D1              jc 0xd318
0000D347  C6069B0601        mov byte [0x69b],0x1
0000D34C  B90500            mov cx,0x5
0000D34F  51                push cx
0000D350  E88E00            call 0xd3e1
0000D353  59                pop cx
0000D354  E2F9              loop 0xd34f
0000D356  A19306            mov ax,[0x693]
0000D359  3B069306          cmp ax,[0x693]
0000D35D  74FA              jz 0xd359
0000D35F  2BC0              sub ax,ax
0000D361  F606C30680        test byte [0x6c3],0x80
0000D366  7418              jz 0xd380
0000D368  40                inc ax
0000D369  F606C40680        test byte [0x6c4],0x80
0000D36E  7410              jz 0xd380
0000D370  40                inc ax
0000D371  F606C50680        test byte [0x6c5],0x80
0000D376  7408              jz 0xd380
0000D378  40                inc ax
0000D379  F606C60680        test byte [0x6c6],0x80
0000D37E  75D6              jnz 0xd356
0000D380  A3F86D            mov [0x6df8],ax
0000D383  B90500            mov cx,0x5
0000D386  51                push cx
0000D387  E85700            call 0xd3e1
0000D38A  59                pop cx
0000D38B  E2F9              loop 0xd386
0000D38D  803E9B0600        cmp byte [0x69b],0x0
0000D392  741A              jz 0xd3ae
0000D394  C7068F6D2000      mov word [0x6d8f],0x20
0000D39A  E84400            call 0xd3e1
0000D39D  E84100            call 0xd3e1
0000D3A0  C7068F6D1800      mov word [0x6d8f],0x18
0000D3A6  E83800            call 0xd3e1
0000D3A9  E83500            call 0xd3e1
0000D3AC  EB15              jmp short 0xd3c3
0000D3AE  C7068F6D1C00      mov word [0x6d8f],0x1c
0000D3B4  E82A00            call 0xd3e1
0000D3B7  E82700            call 0xd3e1
0000D3BA  C7068F6D1600      mov word [0x6d8f],0x16
0000D3C0  E81E00            call 0xd3e1
0000D3C3  E80100            call 0xd3c7
0000D3C6  C3                ret
0000D3C7  803E9B0600        cmp byte [0x69b],0x0
0000D3CC  7409              jz 0xd3d7
0000D3CE  BA0102            mov dx,0x201
0000D3D1  EC                in al,dx
0000D3D2  2410              and al,0x10
0000D3D4  75F8              jnz 0xd3ce
0000D3D6  C3                ret

; The pause loop waiting for a keystroke.
0000D3D7  A19306            mov ax,[0x693]
0000D3DA  3B069306          cmp ax,[0x693]
0000D3DE  74FA              jz 0xd3da
0000D3E0  C3                ret

0000D3E1  8B1E8F6D          mov bx,[0x6d8f]
0000D3E5  8B97636D          mov dx,[bx+0x6d63]
0000D3E9  E89FFE            call 0xd28b
0000D3EC  8B1E8F6D          mov bx,[0x6d8f]
0000D3F0  83068F6D02        add word [0x6d8f],byte +0x2
0000D3F5  8BB7376D          mov si,[bx+0x6d37]
0000D3F9  E85FFE            call 0xd25b
0000D3FC  C3                ret
0000D3FD  FC                cld
0000D3FE  B800B8            mov ax,0xb800
0000D401  8EC0              mov es,ax
0000D403  2BC0              sub ax,ax
0000D405  8BF8              mov di,ax
0000D407  B9A00F            mov cx,0xfa0
0000D40A  F3AB              rep stosw
0000D40C  BF0020            mov di,0x2000
0000D40F  B9A00F            mov cx,0xfa0
0000D412  F3AB              rep stosw
0000D414  C3                ret
0000D415  CD11              int 0x11
0000D417  A90010            test ax,0x1000
0000D41A  740A              jz 0xd426
0000D41C  E82000            call 0xd43f
0000D41F  731D              jnc 0xd43e
0000D421  E81B00            call 0xd43f
0000D424  7318              jnc 0xd43e
0000D426  C7068F6D2400      mov word [0x6d8f],0x24
0000D42C  B90400            mov cx,0x4
0000D42F  E8AFFF            call 0xd3e1
0000D432  E2FB              loop 0xd42f
0000D434  A19306            mov ax,[0x693]
0000D437  3B069306          cmp ax,[0x693]
0000D43B  74FA              jz 0xd437
0000D43D  F9                stc
0000D43E  C3                ret

0000D43F  BA0102            mov dx,0x201
0000D442  EE                out dx,al
0000D443  2AE4              sub ah,ah
0000D445  CD1A              int 0x1a
0000D447  8916FA6D          mov [0x6dfa],dx
0000D44B  BA0102            mov dx,0x201
0000D44E  EC                in al,dx
0000D44F  A803              test al,0x3
0000D451  7502              jnz 0xd455
0000D453  F8                clc
0000D454  C3                ret

0000D455  2AE4              sub ah,ah
0000D457  CD1A              int 0x1a
0000D459  2B16FA6D          sub dx,[0x6dfa]
0000D45D  83FA12            cmp dx,byte +0x12
0000D460  72E9              jc 0xd44b
0000D462  F9                stc
0000D463  C3                ret

0000D464  0000              add [bx+si],al
0000D466  0000              add [bx+si],al
0000D468  0000              add [bx+si],al
0000D46A  0000              add [bx+si],al
0000D46C  0000              add [bx+si],al
0000D46E  0000              add [bx+si],al
0000D470  FC                cld
0000D471  1E                push ds
0000D472  07                pop es
0000D473  BF0E00            mov di,0xe
0000D476  B92400            mov cx,0x24
0000D479  2BC0              sub ax,ax
0000D47B  F3AB              rep stosw
0000D47D  C706246F2500      mov word [0x6f24],0x25
0000D483  B800B8            mov ax,0xb800
0000D486  8EC0              mov es,ax
0000D488  E87DB3            call 0x8808 		; Get vertical retrace status.
0000D48B  74FB              jz 0xd488
0000D48D  BE0E00            mov si,0xe 			; Draws the sprite.
0000D490  8B3E246F          mov di,[0x6f24]		;
0000D494  B9030C            mov cx,0xc03		;
0000D497  E833CD            call 0xa1cd                 ;
0000D49A  8106246FE001      add word [0x6f24],0x1e0
0000D4A0  BE106E            mov si,0x6e10		; Draws the happy cat face sprite.
0000D4A3  8B3E246F          mov di,[0x6f24]		;
0000D4A7  B9030C            mov cx,0xc03		;
0000D4AA  E820CD            call 0xa1cd                 ;
0000D4AD  2AE4              sub ah,ah
0000D4AF  CD1A              int 0x1a
0000D4B1  3B16266F          cmp dx,[0x6f26]
0000D4B5  74F6              jz 0xd4ad
0000D4B7  8916266F          mov [0x6f26],dx
0000D4BB  803E000000        cmp byte [0x0],0x0
0000D4C0  7415              jz 0xd4d7
0000D4C2  B0B6              mov al,0xb6
0000D4C4  E643              out 0x43,al
0000D4C6  A1246F            mov ax,[0x6f24]
0000D4C9  D1E8              shr ax,1
0000D4CB  E642              out 0x42,al
0000D4CD  8AC4              mov al,ah
0000D4CF  E642              out 0x42,al
0000D4D1  E461              in al,0x61
0000D4D3  0C03              or al,0x3
0000D4D5  E661              out 0x61,al
0000D4D7  813E246F401A      cmp word [0x6f24],0x1a40
0000D4DD  72A9              jc 0xd488
0000D4DF  BE586E            mov si,0x6e58		; Draws the angry cat face sprite.
0000D4E2  8B3E246F          mov di,[0x6f24]		;
0000D4E6  B90611            mov cx,0x1106		;
0000D4E9  E8E1CC            call 0xa1cd                 ;
0000D4EC  2AE4              sub ah,ah
0000D4EE  CD1A              int 0x1a
0000D4F0  3B16286F          cmp dx,[0x6f28]
0000D4F4  74F6              jz 0xd4ec
0000D4F6  8916286F          mov [0x6f28],dx
0000D4FA  803E000000        cmp byte [0x0],0x0
0000D4FF  7415              jz 0xd516
0000D501  B0B6              mov al,0xb6
0000D503  E643              out 0x43,al
0000D505  B8000C            mov ax,0xc00
0000D508  F6C201            test dl,0x1
0000D50B  7403              jz 0xd510
0000D50D  B8540B            mov ax,0xb54
0000D510  E642              out 0x42,al
0000D512  8AC4              mov al,ah
0000D514  E642              out 0x42,al
0000D516  2B16266F          sub dx,[0x6f26]
0000D51A  83FA12            cmp dx,byte +0x12
0000D51D  72CD              jc 0xd4ec
0000D51F  E82FFA            call 0xcf51		; Turn off the PC-Speaker.
0000D522  C3                ret

0000D530  C606F27000        mov byte [0x70f2], 0x0
0000D535  C3                ret

0000D536  2AE4              sub ah,ah
0000D538  CD1A              int 0x1a
0000D53A  3B16EE70          cmp dx,[0x70ee]
0000D53E  7501              jnz 0xd541
0000D540  C3                ret

0000D541  8916EE70          mov [0x70ee],dx
0000D545  E88E01            call 0xd6d6
0000D548  730F              jnc 0xd559
0000D54A  E8C6B0            call 0x8613
0000D54D  E80B01            call 0xd65b
0000D550  E822B0            call 0x8575
0000D553  C606F27000        mov byte [0x70f2],0x0
0000D558  C3                ret

0000D559  803EF27000        cmp byte [0x70f2],0x0
0000D55E  756E              jnz 0xd5ce
0000D560  E8CACC            call 0xa22d            ; Get a random number.
0000D563  8BDA              mov bx,dx
0000D565  81E31F00          and bx,0x1f
0000D569  80FB10            cmp bl,0x10
0000D56C  7228              jc 0xd596
0000D56E  80EB10            sub bl,0x10
0000D571  80FB09            cmp bl,0x9
0000D574  77EA              ja 0xd560
0000D576  B201              mov dl,0x1
0000D578  80FB05            cmp bl,0x5
0000D57B  7202              jc 0xd57f
0000D57D  B2FF              mov dl,0xff
0000D57F  8816F670          mov [0x70f6],dl
0000D583  C606F57006        mov byte [0x70f5],0x6
0000D588  D0E3              shl bl,1
0000D58A  8B87B870          mov ax,[bx+0x70b8]
0000D58E  050400            add ax,0x4
0000D591  A3F370            mov [0x70f3],ax
0000D594  EB22              jmp short 0xd5b8
0000D596  B80C00            mov ax,0xc
0000D599  B201              mov dl,0x1
0000D59B  F6C308            test bl,0x8
0000D59E  7405              jz 0xd5a5
0000D5A0  B82001            mov ax,0x120
0000D5A3  B2FF              mov dl,0xff
0000D5A5  A3F370            mov [0x70f3],ax
0000D5A8  8816F670          mov [0x70f6],dl
0000D5AC  80E307            and bl,0x7
0000D5AF  8A87B070          mov al,[bx+0x70b0]
0000D5B3  0408              add al,0x8
0000D5B5  A2F570            mov [0x70f5],al
0000D5B8  C606F27001        mov byte [0x70f2],0x1
0000D5BD  C606F77001        mov byte [0x70f7],0x1
0000D5C2  C706F0700000      mov word [0x70f0],0x0
0000D5C8  C706EC70FFFF      mov word [0x70ec],0xffff
0000D5CE  813EF070A000      cmp word [0x70f0],0xa0
0000D5D4  7305              jnc 0xd5db
0000D5D6  8306F07004        add word [0x70f0],byte +0x4
0000D5DB  8006F57002        add byte [0x70f5],0x2
0000D5E0  803EF570BF        cmp byte [0x70f5],0xbf
0000D5E5  771D              ja 0xd604
0000D5E7  803EF67001        cmp byte [0x70f6],0x1
0000D5EC  7409              jz 0xd5f7
0000D5EE  832EF37005        sub word [0x70f3],byte +0x5
0000D5F3  720F              jc 0xd604
0000D5F5  EB16              jmp short 0xd60d
0000D5F7  8306F37005        add word [0x70f3],byte +0x5
0000D5FC  813EF3702C01      cmp word [0x70f3],0x12c
0000D602  7209              jc 0xd60d
0000D604  C606F27000        mov byte [0x70f2],0x0
0000D609  E84F00            call 0xd65b
0000D60C  C3                ret

0000D60D  8B0EF370          mov cx,[0x70f3]
0000D611  8A16F570          mov dl,[0x70f5]
0000D615  E8C8CA            call 0xa0e0
0000D618  A3FA70            mov [0x70fa],ax
0000D61B  E8B800            call 0xd6d6
0000D61E  72E4              jc 0xd604
0000D620  E85200            call 0xd675
0000D623  E83500            call 0xd65b
0000D626  E80100            call 0xd62a
0000D629  C3                ret

0000D62A  B800B8            mov ax,0xb800
0000D62D  8EC0              mov es,ax
0000D62F  C606F77000        mov byte [0x70f7],0x0
0000D634  A1F070            mov ax,[0x70f0]
0000D637  25E001            and ax,0x1e0
0000D63A  05306F            add ax,0x6f30
0000D63D  803EF670FF        cmp byte [0x70f6],0xff
0000D642  7403              jz 0xd647
0000D644  05C000            add ax,0xc0
0000D647  8BF0              mov si,ax
0000D649  8B3EFA70          mov di,[0x70fa]
0000D64D  893EF870          mov [0x70f8],di
0000D651  BDCC70            mov bp,0x70cc
0000D654  B90208            mov cx,0x802
0000D657  E8A2CA            call 0xa0fc
0000D65A  C3                ret

0000D65B  803EF77000        cmp byte [0x70f7],0x0
0000D660  7512              jnz 0xd674
0000D662  B800B8            mov ax,0xb800		; Draws the sprite.
0000D665  8EC0              mov es,ax			;
0000D667  BECC70            mov si,0x70cc		;
0000D66A  8B3EF870          mov di,[0x70f8]		;
0000D66E  B90208            mov cx,0x802		;
0000D671  E859CB            call 0xa1cd			;
0000D674  C3                ret

0000D675  A0F570            mov al,[0x70f5]
0000D678  2C08              sub al,0x8
0000D67A  24F8              and al,0xf8
0000D67C  B90700            mov cx,0x7
0000D67F  8BD9              mov bx,cx
0000D681  4B                dec bx
0000D682  3A87D42B          cmp al,[bx+0x2bd4]
0000D686  7403              jz 0xd68b
0000D688  E2F5              loop 0xd67f
0000D68A  C3                ret

0000D68B  A1F370            mov ax,[0x70f3]
0000D68E  B104              mov cl,0x4
0000D690  D3E8              shr ax,cl
0000D692  2D0200            sub ax,0x2
0000D695  72F3              jc 0xd68a
0000D697  3D1000            cmp ax,0x10
0000D69A  73EE              jnc 0xd68a
0000D69C  8BF8              mov di,ax
0000D69E  8A97DB2B          mov dl,[bx+0x2bdb]
0000D6A2  2AF6              sub dh,dh
0000D6A4  03C2              add ax,dx
0000D6A6  3B06EC70          cmp ax,[0x70ec]
0000D6AA  74DE              jz 0xd68a
0000D6AC  A3EC70            mov [0x70ec],ax
0000D6AF  8BF0              mov si,ax
0000D6B1  80B4E22B02        xor byte [si+0x2be2],0x2
0000D6B6  8A84E22B          mov al,[si+0x2be2]
0000D6BA  2AE4              sub ah,ah
0000D6BC  D1E7              shl di,1
0000D6BE  8B8DFC70          mov cx,[di+0x70fc]
0000D6C2  8A972071          mov dl,[bx+0x7120]
0000D6C6  50                push ax
0000D6C7  51                push cx
0000D6C8  52                push dx
0000D6C9  E88FFF            call 0xd65b
0000D6CC  5A                pop dx
0000D6CD  59                pop cx
0000D6CE  5B                pop bx
0000D6CF  E841CE            call 0xa513
0000D6D2  E855FF            call 0xd62a
0000D6D5  C3                ret

0000D6D6  803EF27000        cmp byte [0x70f2],0x0
0000D6DB  7502              jnz 0xd6df
0000D6DD  F8                clc
0000D6DE  C3                ret

0000D6DF  A1F370            mov ax,[0x70f3]
0000D6E2  8A16F570          mov dl,[0x70f5]
0000D6E6  BE1000            mov si,0x10
0000D6E9  8B1E7905          mov bx,[0x579]
0000D6ED  8A367B05          mov dh,[0x57b]
0000D6F1  BF1800            mov di,0x18
0000D6F4  B9080E            mov cx,0xe08
0000D6F7  E85FCB            call 0xa259
0000D6FA  731E              jnc 0xd71a
0000D6FC  C606710501        mov byte [0x571],0x1
0000D701  C606760502        mov byte [0x576],0x2
0000D706  C606780520        mov byte [0x578],0x20
0000D70B  C6065B0508        mov byte [0x55b],0x8
0000D710  B81D09            mov ax,0x91d
0000D713  BBE40C            mov bx,0xce4
0000D716  E852F6            call 0xcd6b
0000D719  F9                stc
0000D71A  C3                ret

48: Up Arrow
50: Down Arrow
4B: Left Arrow
4D: Right Arrow
47: Home
4F: End
49: Page Up
51: Page Down
53: Delete 
Alphabetical & Action Keys
These appear to be common commands for a game or interface (e.g., Yes, No, Home/Help, Map, Save).
1E: A
23: H
25: K
32: M
31: N
13: R
1F: S
14: T
15: Y
System & Control Keys
01: Esc
38: Left Alt
1D: Left Ctrl
0A: 9 (Top row) 