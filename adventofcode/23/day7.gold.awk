function compare_hands(hand1, v1, hand2, v2,    card1_rank, card2_rank) {
    if (typeof(hand1) == "number" && typeof(hand1) == typeof(hand2))
        return hand1 - hand2
    if (hand1 == hand2) return 0
    if (hand_strength(hand1) < hand_strength(hand2)) return -1
    if (hand_strength(hand1) > hand_strength(hand2)) return +1
    # print "card compare: "hand1, hand2
    for (i = 1; i <= 5; i++) { # compare each card
        card1_rank = index(CARDS, substr(hand1,i,1))
        card2_rank = index(CARDS, substr(hand2,i,1))
        # print card1_rank, card2_rank
        if (card1_rank < card2_rank) return +1
        if (card1_rank > card2_rank) return -1
    }
    return 0
}
function hand_strength(    hand, card2count, c2c) {
    for (i = 1; i <= 5; i++) { # count occurrences of each card
        card2count[substr(hand,i,1)] += 1
    }
    for (i = 1; i <= 13; i++) { # for all possible cards
        if (ARRCARDS[i] in card2count) { # if in card in card2count
            c2c[card2count[ARRCARDS[i]]] += 1 # add count
            # print ARRCARDS[i], card2count[ARRCARDS[i]], c2c[card2count[ARRCARDS[i]]]
        }
    }
    strength = -1
    if (5 in c2c)                            strength = STR_5OK # =5    five of a kind
    if (4 in c2c)                            strength = STR_4OK # =4    four of a kind
    if (3 in c2c && 2 in c2c)                strength = STR_FUL # =3 =2 full house
    if (3 in c2c && 1 in c2c && c2c[1] == 2) strength = STR_3OK # =3 /2 three of a kind
    if (2 in c2c && 1 in c2c && c2c[1] == 1) strength = STR_2PA # =2 =2 two pair
    if (2 in c2c && 1 in c2c && c2c[1] == 3) strength = STR_1PA # =2 /3 one pair
    if (1 in c2c && c2c[1] == 5)             strength = STR_HIG # /5    high card
    ## print ""
    if (index(hand, "J")) {
        # print hand" strength = "strength, length(c2c)
        if      (strength == STR_4OK) strength = STR_5OK
        else if (strength == STR_FUL) strength = STR_5OK
        else if (strength == STR_3OK) strength = STR_4OK
        else if (strength == STR_2PA && card2count["J"] == 1) strength = STR_FUL
        else if (strength == STR_2PA && card2count["J"] != 1) strength = STR_4OK
        else if (strength == STR_1PA) strength = STR_3OK
        else if (strength == STR_HIG) strength = STR_1PA
    }
    ## print hand" strength = "strength, length(c2c)
    return strength
}
BEGIN {
    STR_5OK = 6; STR_4OK = 5; STR_FUL = 4; STR_3OK = 3
    STR_2PA = 2; STR_1PA = 1;
    STR_HIG = 0
    CARDS = "A K Q T 9 8 7 6 5 4 3 2 J"
    split(CARDS, ARRCARDS)
}

{ hand2bid[$1] = $2 }

END {
    PROCINFO["sorted_in"] = "compare_hands"
    for (hand in hand2bid) {
        print hand
        winnings += hand2bid[hand] * ++w
    }
    print winnings
}
