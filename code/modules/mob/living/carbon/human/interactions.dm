/**********************************
*******Interactions code by HONKERTRON feat TestUnit********
**Contains a lot ammount of ERP and MEHANOYEBLYA**
***********************************/

/mob/living/carbon/human/MouseDrop_T(mob/M as mob, mob/user as mob)
	if(M == src || src == usr || M != usr)		return
	if(!Adjacent(src))			return

	usr.partner = src
	make_interaction(machine)

/mob/proc/make_interaction()
	usr.set_machine(src)
	var/dat = {"
	<B><HR><FONT size=3>INTERACTIONS</FONT></B>
	<BR>"}
	usr << browse(dat, text("window=interactions;size=325x500"))
	onclose(usr, "interactions")
	return


/mob/living/carbon/human/make_interaction()
	set_machine(src)

	var/dat = "<B><HR><FONT size=3>INTERACTIONS - [usr.partner]</FONT></B><BR><HR>"
	var/ya = "&#255;"

	var/mob/living/carbon/human/H = usr
	var/mob/living/carbon/human/P = usr.partner
	var/obj/item/organ/external/temp_r = H.organs_by_name["r_hand"]
	var/obj/item/organ/external/temp_l = H.organs_by_name["l_hand"]
	var/hashands = ((temp_r && temp_r.is_usable()) || (temp_l && temp_l.is_usable()))
	temp_r = P.organs_by_name["r_hand"]
	temp_l = P.organs_by_name["l_hand"]
	var/hashands_p = ((temp_r && temp_r.is_usable()) || (temp_l && temp_l.is_usable()))
	var/mouthfree = !( (H.head && (H.head.flags & HEADCOVERSMOUTH)) || (H.wear_mask && (H.wear_mask.flags & MASKCOVERSMOUTH)) )
	var/mouthfree_p = !( (P.head && (P.head.flags & HEADCOVERSMOUTH)) || (P.wear_mask && (P.wear_mask.flags & MASKCOVERSMOUTH)) )
	var/haspenis = ((H.gender == MALE && H.potenzia > -1) && (H.species.name == "Human" || H.species.name == "Unathi" || H.species.name == "Tajara"))
	var/haspenis_p = ((P.gender == MALE && H.potenzia > -1)  && (P.species.name == "Human" || P.species.name == "Unathi" || P.species.name == "Tajara"))
	var/hasvagina = ((H.gender == FEMALE) && (H.species.name == "Human" || H.species.name == "Tajara" || H.species.name == "Slime"))
	var/hasvagina_p = ((P.gender == FEMALE) && (P.species.name == "Human" || P.species.name == "Tajara" || P.species.name == "Slime"))
	var/hasanus_p = (P.species.name == "Human" || P.species.name == "Unathi" || P.species.name == "Tajara" || P.species.name == "Skrell" || P.species.name == "Slime" || istype(P.species, /datum/species/xenos))
	var/isnude = ( !(H.wear_suit) && !(H.w_uniform) && !H.underwear)
	var/isnude_p = ( !(P.wear_suit) && !(P.w_uniform) && !P.underwear)


	//var/mouthfree = !( H.head.flags & HEADCOVERSMOUTH || H.wear_mask.flags & MASKCOVERSMOUTH )
	//var/mouthfree_p = !( P.head.flags & HEADCOVERSMOUTH || P.wear_mask.flags & MASKCOVERSMOUTH )
	//Standart

	dat +=  {"� <A href='?src=\ref[usr];interaction=bow'>�������� ������.</A><BR>"}
	if (hashands)
		dat +=  {"<font size=3><B>����:</B></font><BR>"}
		if (Adjacent(P))
			dat +=  {"� <A href='?src=\ref[usr];interaction=hug'>���������!</A><BR>"}
			if (hashands_p)
				dat +=  {"� <A href='?src=\ref[src];interaction=handshake'>������ ����.</A><BR>"}
				dat +=  {"� <A href='?src=\ref[src];interaction=give'>�������� �������.</A><BR>"}
			dat +=  {"� <A href='?src=\ref[usr];interaction=slap'>���� ��������!</A><BR>"}
			if (isnude_p)
				if (hasanus_p)
					dat += {"� <A href='?src=\ref[usr];interaction=assslap'>�������� �� �������</A><BR>"}
				if (hasvagina_p)
					dat += {"� <A href='?src=\ref[usr];interaction=fingering'>��������� �������...</A><BR>"}
			if (P.species.name == "Tajara")
				dat +=  {"� <A href='?src=\ref[usr];interaction=pull'>ĸ����� �� �����!</A><BR>"}
				if(P.can_inject(H, 1))
					dat +=  {"� <A href='?src=\ref[usr];interaction=pet'>���������.</A><BR>"}

	if (mouthfree)
		dat += {"<font size=3><B>����:</B></font><BR>"}
		if (Adjacent(P))
			if (mouthfree_p)
				dat += {"� <A href='?src=\ref[usr];interaction=kiss'>����������.</A><BR>"}
				if (H.species.name == "Tajara")
					dat += {"� <A href='?src=\ref[usr];interaction=lick'>������� � ����.</A><BR>"}
			if (isnude_p)
				if (haspenis_p)
					dat += {"� <A href='?src=\ref[usr];interaction=blowjob'>������� �����.</A><BR>"}
				if (hasvagina_p)
					dat += {"� <A href='?src=\ref[usr];interaction=vaglick'>��������.</A><BR>"}
				if (hasanus_p)
					dat += {"� <A href='?src=\ref[usr];interaction=asslick'>������������ ������ ���?!</A><BR>"}

	if (isnude && usr.loc == usr.partner.loc)
		if (haspenis)
			dat += {"<font size=3><B>����:</B></font><BR>"}
			if (isnude_p)
				if (hasvagina_p)
					dat += {"� <A href='?src=\ref[usr];interaction=vaginal'>�������� ����������.</A><BR>"}
				if (hasanus_p)
					dat += {"� <A href='?src=\ref[usr];interaction=anal'>�������� �������.</A><BR>"}
				if (mouthfree_p)
					dat += {"� <A href='?src=\ref[usr];interaction=oral'>�������� �������.</A><BR>"}
	if (isnude && usr.loc == usr.partner.loc)
		if (hasvagina && haspenis_p)
			dat += {"<font size=3><B>����:</B></font><BR>"}
			dat += {"� <A href='?src=\ref[usr];interaction=mount'>��������!</A><BR>"}

	usr << browse(dat, text("window=interactions;size=340x480"))
	onclose(usr, "interactions")
	return

//INTERACTIONS
/mob
	var/mob/living/carbon/human/partner

/mob/living/carbon
	var/mob/living/carbon/human/lastfuckedv
	var/mob/living/carbon/human/lastfuckeda
	var/mob/living/carbon/human/lastfuckedo
	var/potenzia = 10
	var/resistenza = 200
	var/lust = 0
	var/erpcooldown = 0
	var/multiorgasms = 0
	var/lastmoan = 0

mob/living/carbon/human/proc/cum(mob/living/carbon/human/H as mob, mob/living/carbon/human/P as mob, var/hole)
	var/message = "������� �� ���!"
	var/ya = "&#255;"
	var/turf/T

	if (H.species.name == "Xenomorph Queen" || H.species.name == "Xenomorph Hunter" || H.species.name == "Xenomorph Drone" || H.species.name == "Xenomorph Sentinel")
		message = pick("���������[ya] � �������� �������", "����������[ya], � ����� ����� ��������[ya]���[ya]")
		src.visible_message("<B>[src] [message].</B>")
		playsound(loc, "sound/voice/hiss6.ogg", 50, 0, -1)
	else if (H.gender == MALE)
		var/datum/reagent/blood/source = H.get_blood(H.vessel)
		if (P)
			T = get_turf(P)
		else
			T = get_turf(H)
		if (H.multiorgasms < H.potenzia)
			var/obj/effect/decal/cleanable/cum/C = new(T)
			// Update cum information.
			C.blood_DNA = list()
			if(source.data["blood_type"])
				C.blood_DNA[source.data["blood_DNA"]] = source.data["blood_type"]
			else
				C.blood_DNA[source.data["blood_DNA"]] = "O+"

		if (hole == "mouth")
			message = pick("������� [P] � ���.", "������[ya] � ���� [P], �����[ya]�� ����� ����� �������, �� ������������[ya].", "������������� ���[ya] �� ���� [P].", "������� �� ���.")
			playsound(loc, "sound/interactions/final_m[rand(1, 2)].ogg", 50, 1, -1)
		else if (hole == "vagina")
			message = pick("������� � [P]", "����� ���[ya]������ ���� �� [P], � ����� �������� �� ���.", "��������� � [P] ��������� ���, ����� ����������[ya]. ������ �������� �������� �� ���� [P].")
			playsound(loc, "sound/interactions/final_m[rand(1, 2)].ogg", 50, 1, -1)
		else if (hole == "anus")
			message = pick("������� [P] � ���.", "����������� ���� �� [P], � ����� ������� ������� �� [P.gender == MALE ? "���" : "�"] �����.", "���[ya]������ ���� �� ������� [P] � ����� �� �������� �� ���.")
			playsound(loc, "sound/interactions/final_m[rand(1, 2)].ogg", 50, 1, -1)
		else
			playsound(loc, "sound/interactions/final_m[rand(3, 6)].ogg", 50, 1, -1)

		H.visible_message("<B>[H] [message]</B>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<B>[H] [message]</B>")
		H.lust = 5
		H.resistenza += 50

	else
		message = pick("���������[ya] � �������� �������", "���������� ����� � ����� ������", "����������[ya], � ����� ����� ��������[ya]���[ya]", "��������, ������� �����")
		H.visible_message("<B>[H] [message].</B>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<B>[H] [message].</B>")
		playsound(loc, "sound/interactions/final_f[rand(1, 4)].ogg", 50, 0, -1)
		var/delta = pick(20, 30, 40, 50)
		src.lust -= delta

	H.druggy = 60
	H.multiorgasms += 1
	if (H.multiorgasms == 1)
		admin_attack_log(H, P, "Came", "Became a target of a cumshot", "is cumming on")
	var/delta = pick(-50, 0, 50, 100)
	H.erpcooldown = 300 + delta
	if (H.multiorgasms > H.potenzia / 3)
		if (H.halloss < P.potenzia * 4)
			H.halloss += H.potenzia
		if (H.halloss > 100)
			H.druggy = 300
			H.erpcooldown = 600

mob/living/carbon/human/proc/fuck(mob/living/carbon/human/H as mob, mob/living/carbon/human/P as mob, var/hole)
	//var/adverb = pick("�������� ", "[ya]������", "�����", ",�[ya]���� ����, ", "")
	var/ya = "&#255;"
	var/adverb = ""
	var/message = ""

	if (hole == "vaglick")

		message = pick("���������� [P].", "���������� [P].")
		if (prob(35))
			if (P.species.name == "Human")
				//adverb = pick(", ����������[ya],", ", ���������[ya],", " �����", ", �[ya]���� ����,", " ")
				message = pick("���������� [P].", "�������� ����������� [P] [ya]�����.", "���������� [P].", "������� [P] [ya]������.", "��������� ���� [ya]��� � [P]", "�������[ya] � [P] [ya]������", "�������� �������� [ya]����� ����� ����������� [P]")
			if (P.species.name == "Tajara")
				message = pick("���������� [P].", "�������� ����������� [P] [ya]�����.", "���������� [P].", "������� [P] [ya]������.", "��������� ���� [ya]��� � [P]", "�������[ya] � [P] [ya]������", "�������� �������� [ya]����� ����� ����������� [P]")

		if (H.lastfuckedv != P)
			H.lastfuckedv = P
			add_logs(H, P, "licked")

		if (prob(5) && P.stat != DEAD)
			H.visible_message("<font color=purple><B>[H][adverb] [message]</B></font>")
			P.lust += 10
		else
			H.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (P.stat != DEAD && P.stat != UNCONSCIOUS)
			P.lust += 10
			if (P.lust >= P.resistenza)
				P.cum(P, H)
			else
				P.moan()

	if (hole == "fingering")

		message = pick("������ ��� ������ � ������ [P].")
		if (prob(35))
			if (P.species.name == "Human")
				//adverb = pick(", �[ya]���� ������[ya],", ", ��������[ya]��,", " �����", ", �[ya]���� ����,", " ", " ��������", " [ya]������")
				message = pick("������ ��� ������ � ������ [P].", "������� �������� [P].", "����� �������� [P].", "������� [P] ����������.", "����� ����������� ����������� [P].", "��������� ������ ������� � [P], �����[ya] � �������.", "������� ������� [P].")
			if (P.species.name == "Tajara")
				message = pick("������ ��� ������ � �������� ������ [P].", "������� �������� [P].", "����� �������� [P].", "������� [P] ����������.", "����� ����������� ����������� [P].", "��������� ������ ������� � [P], �����[ya] � �������.", "������� ������� [P].")

		if (H.lastfuckedv != P)
			H.lastfuckedv = P
			H.lastfuckeda = ""
			H.lastfuckedo = ""
			add_logs(H, P, "fingered")

		if (prob(5) && P.stat != DEAD)
			H.visible_message("<font color=purple><B>[H][adverb] [message]</B></font>")
			P.lust += 8
		else
			H.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (P.stat != DEAD && P.stat != UNCONSCIOUS)
			P.lust += 8
			if (P.lust >= P.resistenza)
				P.cum(P, H)
			else
				P.moan()
		playsound(loc, "sound/interactions/champ_fingering.ogg", 50, 1, -1)

	if (hole == "blowjob")

		if (H.species.name == "Human" || H.species.name == "Skrell" || H.species.name == "Arachna")
			message = pick("���������� [P].", "����� ���� [P].", "����������� ���� [P] [ya]�����.")
			if (prob(35))
				message = pick("������ ����� [P], ������� ����� �� �����������[ya].", "�����������, ������� �����, �� ������[ya] ���� [P] ��� ���.", "������������ ����� ���� [P], ������� ��� [ya]������.", "���������� ���� [P] �� ���� �����.", "��������� ���� [P] ��� ������ ���� � ���.", "�������� [ya]���� ���������� ������� ����� [P].", "����� �� ������ ����� [P] � ����� ���� ��� � ���.", "���� ������� [P].", "������� ������� ����-�����, ���������[ya] ���� [P].", "��������� ���������� ���� [P].", "������������, ��������� ����������� ������ [P].", "������� ���� [P], ������[ya] ���� ������.")
			if (H.lastfuckedo != P)
				message = pick("�[ya]��� ����������� ���� [P] ������.", "���������� ������ ���� [P].")
				H.lastfuckedo = P
				H.lastfuckeda = ""
				H.lastfuckedv = ""
				add_logs(H, P, "sucked")

		else if (H.species.name == "Unathi")
			message = pick("���������� ���� [P].", "����������� ����� [P] [ya]�����.", "��� ���� [P] � ���� [ya]���.", "������������ ���� [P] ���� � �����, �����[ya]�� �� �������� ��� ������.", "����������� ���� [P] [ya]�����.")
			if (prob(35))
				message = pick("���������� ����� [P], ������� ����� �� �����������[ya].", "�����������, ������� �����, �� ������[ya] ���� [P] �� �����.", "������������ ����� ���� [P], ������� ��� [ya]������.", "���������� ���� [P] �� ���� �����.", "��������� ���� [P] ��� ������ ���� � �����.", "�������� [ya]���� ���������� ������� ����� [P].", "����� �� ������ ����� [P] � ������������ ��� ���� � ������.", "���������� ������� [P].", "������� ������� ����-�����, ���������[ya] ���� [P].", "��������� ���������� ���� [P].", "������������, ��������� ����������� ������ [P].", "������� ���� [P], ������[ya] ���� ������.")
			if (H.lastfuckedo != P)
				message = pick("�������� [ya]���� �������[ya] ����� [P].", "���������� ���������� ���� [P].")
				H.lastfuckedo = P
				H.lastfuckeda = ""
				H.lastfuckedv = ""
				add_logs(H, P, "sucked")

		else if (H.species.name == "Tajara")
			message = pick("���������� ���� [P].", "������� ����� �������� [ya]������ ������ ����� [P].", "������������ ���� [P] ���� � �����, �����[ya]�� �� �������� ��� ������.", "����������� ���� [P] [ya]�����.")
			if (prob(35))
				message = pick("���������� ����� [P], ������� ����� �� �����������[ya].", "�����������, ������� �����, �� ������[ya] ���� [P] �� �����.", "������������ ����� ���� [P], ������� ��� [ya]������.", "���������� ���� [P] �� ���� �����.", "��������� ���� [P] ��� ������ ���� � �����.", "�������� [ya]���� ���������� ������� ����� [P].", "����� �� ������ ����� [P] � ������������ ��� ���� � ������.", "���������� ������� [P].", "������� ������� ����-�����, ���������[ya] ���� [P].", "��������� ���������� ���� [P].", "������������, ��������� ����������� ������ [P].", "������� ���� [P], ������[ya] ���� ������.")
			if (H.lastfuckedo != P)
				message = pick("�������� [ya]���� �������[ya] ����� [P].", "���������� ���������� ���� [P].")
				H.lastfuckedo = P
				H.lastfuckeda = ""
				H.lastfuckedv = ""
				add_logs(H, P, "sucked")

		else if (H.species.name == "Vox")
			message = pick("���������� ���� [P].", "����������� ����� [P] [ya]�����.", "��� ���� [P] � ���� [ya]���.", "������������ ���� [P] ���� � ������, �����[ya]�� �� �������� ��� ������.", "����������� ���� [P] [ya]�����.")
			if (prob(35))
				message = pick("���������� ����� [P], ������� ����� �� �����������[ya].", "�����������, ������� �����, �� ������[ya] ���� [P] �� �����.", "������������ ����� ���� [P], ������� ��� [ya]������.", "���������� ���� [P] �� ���� �����.", "��������� ���� [P] ��� ������ ���� � ����.", "�������� [ya]���� ���������� ������� ����� [P].", "����� �� ������ ����� [P] � ������������ ��� ���� � ������.", " ���������� ������� [P].", "������� ������� ����-�����, ���������[ya] ���� [P].", "��������� ���������� ���� [P].", "������������, ��������� ����������� ������ [P].", "������� ���� [P] [ya]�����.")
			if (H.lastfuckedo != P)
				message = pick("�������� [ya]���� �������[ya] ����� [P].", "���������� ���������� ���� [P].")
				H.lastfuckedo = P
				H.lastfuckeda = ""
				H.lastfuckedv = ""
				add_logs(H, P, "sucked")

		else if (H.species.name == "Xenomorph Queen" || P.species.name == "Xenomorph Hunter" || P.species.name == "Xenomorph Drone" || P.species.name == "Xenomorph Sentinel")
			message = pick("���������� ���� [P].", "����������� ����� [P] [ya]�����.", "��� ���� [P] � ���� [ya]���.")
			if (prob(35))
				message = pick("���������� ����� [P]", "�����������, ������� �����, �� ������[ya] ���� [P] �� ������ ����� ����� �������.", "������������ ����� ���� [P], ������� ��� [ya]������.", "���������� ���� [P] �� ���� �����.", "��������� ���� [P] ��� ������ ���� � ����� �������.", "�������� [ya]���� ���������� ������� ����� [P].", "����� �� ������ ����� [P] � ����� ���� ��� � ����� �������.", " ���������� ������� [P].", "������� ������������ ������� ����-�����, ���������[ya] ���� [P].", "��������� ���������� ���� [P].", "��������� ����������� ������ [P].")
			if (H.lastfuckedo != P)
				message = pick("�������� [ya]���� �������[ya] ����� [P].", "���������� ���������� ���� [P].")
				H.lastfuckedo = P
				H.lastfuckeda = ""
				H.lastfuckedv = ""
				add_logs(H, P, "sucked")

		else if (H.species.name == "Slime")
			message = pick("���������� [P].", "����� ���� [P].", "����������� ���� [P] [ya]�����.")
			if (prob(35))
				message = pick("������ ������ ����� [P], ������� ����� �� �����������[ya].", "�����������, ������� �����, �� ������[ya] ���� [P] ��� ���.", "������� ���� [P] [ya]������, �������[ya] ��� �[ya]���� ������.", "���������� ���� [P] �� ���� �����, ������[ya][ya] ���� �� �����.", "��������� ���� [P] ��� ������ ���� � ���.", "�������� [ya]���� ���������� ������� ����� [P].", "��������� ������ ����� [P] ������ ������ � ����� ���� ��� � ���.", "����� ������� [P].", "������� ������� ����-�����, ���������[ya] ���� [P].", "��������� ���������� ���� [P].", "������������, ��������� ����������� ������ [P].", "������� ���� [P], ������[ya] ���� ������.")
			if (H.lastfuckedo != P)
				message = pick("�[ya]��� ����������� ���� [P] ������, ����������[ya] ��� ������.", "���������� ������ ���� [P].")
				H.lastfuckedo = P
				H.lastfuckeda = ""
				H.lastfuckedv = ""
				add_logs(H, P, "sucked")

		if (prob(5))
			P.oxyloss += 3
		if (H.lust < 6)
			H.lust += 6
		if (prob(5) && P.stat != DEAD)
			H.visible_message("<font color=purple><B>[H][adverb] [message]</B></font>")
			P.lust += 10
		else
			H.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (P.stat != DEAD && P.stat != UNCONSCIOUS)
			P.lust += 10
			if (P.lust >= P.resistenza)
				P.cum(P, H, "mouth")
		playsound(loc, "sound/interactions/bj[rand(1, 11)].ogg", 50, 1, -1)

	if (hole == "vaginal")

		message = pick("������� [P].", "������� [P].", "������ [P].")
		if (prob(35))
			if (P.species.name == "Human")
				//adverb = pick(" [ya]������", " ��������", " �����", ", �[ya]���� ����,", ", ��� ����� �����,")
				message = pick("����� ������� [P].", "�������[ya] ��������� ����� � [P].", "������ ��������� ����������[ya] ������ [P].", "�������[ya] ������ [P].", "������� �����, ��������[ya] ���� � [P].", "������, ��������[ya]�� �� [P].", "������ ����������[ya] ����� � [P].", "���������� [P] �� ���� ����.", "���������� ����� [P].")
			else if (P.species.name == "Tajara")
				message = pick("����� ������� [P].", "�������[ya] ��������� ����� � [P].", "������ ��������� ����������[ya] ������ [P].", "�������[ya] ������ [P].", "������� �����, ��������[ya] ���� � [P].", "������, ��������[ya]�� �� [P].", "������ ����������[ya] ����� � [P].", "���������� [P] �� ���� ����.", "���������� ����� [P].")
			else if (P.species.name == "Slime")
				message = pick("����� ������� [P].", "�������[ya] ��������� ����� � [P].", "������ ��������� ����������[ya] ������ [P].", "�������[ya] ������ [P].", "������� �����, ��������[ya] ���� � [P].", "������, ��������[ya]�� �� [P].", "������ ����������[ya] ����� � [P].", "���������� [P] �� ���� ����.", "���������� ����� [P].")
				playsound(loc, "sound/interactions/champ[rand(1, 2)].ogg", 50, 1, -1)

		if (H.lastfuckedv != P)
			message = pick("��������� ���� ���� �� ����� [ya]��� � [P].", "������ ���� ����� ����� � ���� [P].", "��������� ���� ������ ������ ������ [P].", "��������� � [P].")
			H.lastfuckedv = P
			H.lastfuckeda = ""
			H.lastfuckedo = ""
			add_logs(H, P, "fucked")

		if (prob(5) && P.stat != DEAD)
			H.visible_message("<font color=purple><B>[H][adverb] [message]</B></font>")
			P.lust += H.potenzia * 2
		else
			H.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<font color=purple>[H][adverb] [message]</font>")
		H.lust += 10
		if (H.lust >= H.resistenza)
			H.cum(H, P, "vagina")
		H.moan()
		if (P.stat != DEAD && P.stat != UNCONSCIOUS)
			P.lust += H.potenzia
			if (P.lust >= P.resistenza)
				P.cum(P, H)
			else
				P.moan()
		playsound(loc, "sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)

	if (hole == "anal")

		message = pick("������ [P] � ����.", "������� ������� [P].", "������� [P] � ����.")
		if (prob(35))
			if (P.species.name == "Human")
				message = pick("������� [P] � �������.", "��������� ���� [P] � �������� ������ �� ����� [ya]���.", "����� ����� � ����� [P].", "��������� [P] ���� �������� ������y��.", "��������� ������ ������� � �������� ����� [P].")
			else if (P.species.name == "Unathi")
				message = pick("������� [P] � ������.", "��������� ���� [P] � �������� ������ �� ����� [ya]���.", "����� ����� � ����� [P].", "��������� [P] ���� �������� ������y��.", "��������� ������ ������� � �������� ����� [P].")
			else if (P.species.name == "Tajara")
				message = pick("������� [P] ��� �����.", "��������� ���� [P] � �������� ������ �� ����� [ya]���.", "������ [P] ��� �������� �������.", "����� ����� � ����� [P].", "��������� [P] ���� �������� ������y��.", "��������� ������ ������� � �������� ����� [P].")
			else if (P.species.name == "Skrell")
				message = pick("������� [P] � ������.", "��������� ���� [P] � �������� ������ �� ����� [ya]���.", "����� ����� � ����� [P].", "��������� [P] ���� �������� ������y��.", "��������� ������ ������� � �������� ����� [P].")
			else if (P.species.name == "Xenomorph Queen" || P.species.name == "Xenomorph Hunter" || P.species.name == "Xenomorph Drone" || P.species.name == "Xenomorph Sentinel")
				message = pick("������� [P] � �������� ������.", "��������� ���� [P] � �������� ������ �� ����� [ya]���.", "����� ����� � ����� [P].", "��������� [P] ���� �������� ������y��.", "��������� ������ ������� � �������� ����� [P].")
			if (P.species.name == "Human")
				message = pick("������� [P] � �������.", "��������� ���� [P] � �������� ������ �� ����� [ya]���, ������� � ������ �����.", "��������� [P] ���� �������� ������y��.")
				playsound(loc, "sound/interactions/champ[rand(1, 2)].ogg", 50, 1, -1)

		if (H.lastfuckeda != P)
			message = pick(" ����������� ��������� �������� ��������� [P].", "��������� ���� [P] � ����.")
			H.lastfuckeda = P
			H.lastfuckedo = ""
			H.lastfuckedv = ""
			add_logs(H, P, "fucked in anus")

		if (prob(5) && P.stat != DEAD)
			H.visible_message("<font color=purple><B>[H][adverb] [message]</B></font>")
			P.lust += H.potenzia * 2
		else
			H.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<font color=purple>[H][adverb] [message]</font>")
		H.lust += 12
		if (H.lust >= H.resistenza)
			H.cum(H, P, "anus")
		H.moan()
		if (P.stat != DEAD && P.stat != UNCONSCIOUS)
			P.lust += H.potenzia * 0.5
			if (P.lust >= P.resistenza)
				P.cum(P, H)
			else
				P.moan()
		playsound(loc, "sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)

	if (hole == "oral")

		message = pick("������� [P], ��������[ya] ���� ���� [P.gender == FEMALE ? "��" : "���"] � ������.", "������� ������� [P].")
		if (prob(35))
			if (P.species.name == "Human")
				//adverb = pick(" [ya]������", " ��������", " �����", ", �[ya]���� ����,", ", ��� ����� �����,")
				message = pick(" ��������[ya] �� ����� [P], ����������[ya] [P.gender==FEMALE ? "�" : "���"] � ��������[ya] ���� �� ������� � ������� [P.gender==FEMALE ? "��" : "���"] � ������.", " ������� [P] � ���.", " ���������� ������ [P] �� ���� ����.", " ������ [P] �� ������ ����[ya] ������ � ��������� �������[ya] �����.", " ��� �������� [P], ��������[ya] ����� ������ � ���.", " ��������� ���������[ya] ������� [P].", ", ���� ������ ����, ���[ya]������ ������ [P] �� ������ ������.")
			else if (P.species.name == "Unathi")
				message = pick(" ��������[ya] �� ����� [P], ����������[ya] [P.gender==FEMALE ? "�" : "���"] � ��������[ya] ���� �� ������� � ������� [P.gender==FEMALE ? "��" : "���"] � ������.", " ������� [P] � �������� �����.", " ���������� ������ [P] �� ���� ����.", " ������ [P] �� ������ ����[ya] ������ � ��������� �������[ya] �����.", " ��� �������� [P], ��������[ya] ����� [P.gender == FEMALE ? "������ [ya]�����" : "������� [ya]����"] � �����.", " ��������� ���������[ya] ������� [P].", ", ���� ������ ����, ���[ya]������ ������ [P] �� ������ ������.")
			else if (P.species.name == "Tajara")
				message = pick(" ��������[ya] �� ����� [P], ����������[ya] [P.gender==FEMALE ? "�" : "���"] � ��������[ya] ���� �� ������� � ������� [P.gender==FEMALE ? "��" : "���"] � ������.", " ������� [P] � �������� �����.", " ���������� ������ [P] �� ���� ����.", " ������ [P] �� ������ ����[ya] ������ � ��������� �������[ya] �����.", " ��� �������� [P], ��������[ya] ����� [P.gender == FEMALE ? "������ �������" : "������� ������"] � �����.", " ��������� ���������[ya] ������� [P].", ", ���� ������ ����, ���[ya]������ ������ [P] �� ������ ������.")
			else if (P.species.name == "Skrell")
				message = pick(" ��������[ya] �� ����� [P], ����������[ya] [P.gender==FEMALE ? "�" : "���"] � ��������[ya] ���� �� ������� � ������� [P.gender==FEMALE ? "��" : "���"] � ������.", " ������� [P] � ���.", " ���������� ������ [P] �� ���� ����.", " ������ [P] �� ������ ����[ya] ������ � ��������� �������[ya] �����.", " ��� �������� [P], ��������[ya] ����� ������ � ���.", " ��������� ���������[ya] ������� [P].", ", ���� ������ ����, ���[ya]������ ������ [P] �� ������ ������.")
			else if (P.species.name == "Vox")
				message = pick(" ��������[ya] �� ����� [P], ����������[ya] [P.gender==FEMALE ? "�" : "���"] � ��������[ya] ���� �� ������� � ������� [P.gender==FEMALE ? "��" : "���"] � ������.", " ������� [P] ��[ya]�� � ����.", " ���������� ������ [P] �� ���� ����, �����[ya]�� �� ���������[ya] � ������� �� �����.", " ������ [P] �� ������ ����[ya] ������ � ��������� �������[ya] �����.", " ������� ����[ya] �� ������ [P], ��������[ya] ����� ������ ������ � ���.", " ��������� ���������[ya] ������� [P].", ", ���� ������ ����, ���[ya]������ ������ [P] �� ������ ������.")
			else if (P.species.name == "Xenomorph Queen" || P.species.name == "Xenomorph Hunter" || P.species.name == "Xenomorph Drone" || P.species.name == "Xenomorph Sentinel")
				message = pick(" ��������[ya] �� ����� [P], ����������[ya] � � ��������[ya] ���� �� ������� � ������� � � ���������� �������.", " ������� [P] � ����� �������.", " ���������� ������ [P] �� ���� ����.", " ������ [P] �� ������������ ������ ����[ya] ������ � ��������� �������[ya] �����.", " ��������� ���������[ya] ������� [P].", ", ���� ������ ����, ���[ya]������ ������ [P] �� ������ ������.")
			else if (P.species.name == "Arachna")
				message = pick(" ��������[ya] �� ����� [P], ����������[ya] ������� � ��������[ya] ���� �� ������� � ������� �� � ������.", " ������� [P] � ���.", " ���������� ������ [P] �� ���� ����.", " ������ [P] �� ������ ����[ya] ������ � ��������� �������[ya] �����.", " ��� �������� [P], ��������[ya] ����� ������� � ���.", " ��������� ���������[ya] ������� [P].", ", ���� ������ ����, ���[ya]������ ������ [P] �� ������ ������.")
			else if (P.species.name == "Slime")
				message = pick(" ��������[ya] �� ������������ ����� [P], ����������[ya] [P.gender==FEMALE ? "�" : "���"] � ��������[ya] ���� �� ������� � ������� [P.gender==FEMALE ? "��" : "���"] � ������.", " ������� [P] � ���, ���[ya]����[ya] ���� ���� � ������ �����.", " ���������� ������ [P] �� ���� ����.", " ������ [P] �� ������ ����[ya] ������ � ��������� �������[ya] �����.", " ���������� ����� [P.gender == FEMALE ? "������ �����������" : "������� �����[ya]"] � ���.", " ��������� ���������[ya] ������� [P].", ", ���������� ���������, ������ ������ ���� ��� [P] � ������ �� ��������� ��������.", " ������� �������� ������ [P].")
				playsound(loc, "sound/interactions/champ[rand(1, 2)].ogg", 50, 1, -1)

		if (H.lastfuckedo != P)
			message = pick(" ������������ ������������ ���� ���� [P] � ������.")
			H.lastfuckedo = P
			H.lastfuckeda = ""
			H.lastfuckedv = ""
			add_logs(H, P, "fucked in mouth")

		if (prob(10))
			P.oxyloss += 3
		if (prob(5) && H.stat != DEAD)
			H.visible_message("<font color=purple><B>[H][message]</B></font>")
		else
			H.visible_message("<font color=purple>[H][adverb] [message]</font>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<font color=purple>[H][adverb] [message]</font>")
		H.lust += 15
		if (H.lust >= H.resistenza)
			H.cum(H, P, "mouth")
		else
			H.moan()
		playsound(loc, "sound/interactions/oral[rand(1, 2)].ogg", 50, 1, -1)

	if (hole == "mount")

		message = pick("������ �� ����� [P].", "������� �� ������������ [P].", "�����������[ya] �� [P].")
		if (prob(35))
			message = pick("������� ���� [P], ������ ���������", "������ �� ������ [P]", "������� �� [P], ����[ya][ya]�� � ��� ������� ����", "�������� ������������, �������[ya][ya] ������������ ���� � [P]", "�������� ����� � [P] � ������, ��� �����", "������ �������� �� ������� ������ [P]", "���������� �����������[ya] �� [P], ��[ya]� ������ ��� ����", "����������� ��� ���� �� ������ [P], ���[ya] �� ���� ����� �����", "�������� ������ ���[ya] ������� [P]")

		if (H.lastfuckedv != P)
			message = pick("��������� �����������[ya] �� ������� ����� [P].")
			H.lastfuckedv = P
			H.lastfuckeda = ""
			H.lastfuckedo = ""
			add_logs(H, P, "fucked")

		if (prob(5) && P.stat != DEAD)
			H.visible_message("<font color=purple><B>[H] [message]!</B></font>")
			P.lust += H.potenzia * 2
		else
			H.visible_message("<font color=purple>[H] [message]</font>")
		if (istype(P.loc, /obj/structure/closet))
			P.visible_message("<font color=purple>[H][adverb] [message]</font>")
		H.lust += P.potenzia * 1.5
		if (H.lust >= H.resistenza)
			H.cum(H, P)
		else
			H.moan()
		if (P.stat != DEAD && P.stat != UNCONSCIOUS)
			P.lust += H.potenzia
			if (P.lust >= P.resistenza)
				P.cum(P, H, "vagina")
			else
				P.moan()
		playsound(loc, "sound/interactions/bang[rand(1, 3)].ogg", 70, 1, -1)
		if (H.species.name == "Slime")
			playsound(loc, "sound/interactions/cmamp[rand(1, 2)].ogg", 70, 1, -1)

mob/living/carbon/human/proc/moan()
	var/ya = "&#255;"
	var/mob/living/carbon/human/H = src
	if (H.species.name == "Human" || H.species.name == "Skrell" || H.species.name == "Arachna" || H.species.name == "Slime")
		if (prob(src.lust / src.resistenza * 70))
			var/message = pick("�����������", "������ �� �����������[ya]", "���������� �����", "���������� ����")
			src.visible_message("<B>[src]</B> [message].")
			var/moan = 0
			if (src.gender == FEMALE)
				if (src.lust > src.lust * 0.75)
					moan = rand(14, 18)
					if (moan == src.lastmoan)
						moan -= 1
					playsound(loc, "sound/interactions/moan_f[moan].ogg", 50, 0, -1)
					src.lastmoan = moan
				else
					moan = rand(2, 13)
					if (moan == src.lastmoan)
						moan -= 1
					playsound(loc, "sound/interactions/moan_f[moan].ogg", 50, 0, -1)
					src.lastmoan = moan
	else if (H.species.name == "Tajara")
		if (prob(src.lust / src.resistenza * 70))
			var/message = pick("��������", "�������� �� �����������[ya]", "���������� �����", "�������� �����������[ya]")
			src.visible_message("<B>[src]</B> [message].")
			if (src.gender == FEMALE)
				playsound(loc, "sound/interactions/purr_f[rand(1, 2)].ogg", 50, 0, -1)
	else if (H.species.name == "Xenomorph Queen" || H.species.name == "Xenomorph Hunter" || H.species.name == "Xenomorph Drone" || H.species.name == "Xenomorph Sentinel")
		if (prob(src.lust / src.resistenza * 70))
			var/message = pick("�������� �����", "���������[ya] �� �����������[ya]")
			src.visible_message("<B>[src]</B> [message].")
			playsound(loc, "sound/voice/hiss[rand(2, 4)].ogg", 50, 0, -1)
	else if (H.species.name == "Unathi")
		if (prob(src.lust / src.resistenza * 70))
			var/message = pick("�������� �����", "���������[ya] �� �����������[ya]")
			src.visible_message("<B>[src]</B> [message].")
