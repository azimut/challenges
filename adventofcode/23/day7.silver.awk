function compare_hands(hand1, v1, hand2, v2,    card1_rank, card2_rank) {
    if (typeof(hand1) == "number" && typeof(hand1) == typeof(hand2))
        return hand1 - hand2
    if (hand1 == hand2) return 0
    if (hand_strength(hand1) < hand_strength(hand2)) return -1
    if (hand_strength(hand1) > hand_strength(hand2)) return +1
    for (i = 1; i <= 5; i++) { # compare each card
        card1_rank = index(CARDS, substr(hand1,i,1))
        card2_rank = index(CARDS, substr(hand2,i,1))
        if (card1_rank < card2_rank) return +1
        if (card1_rank > card2_rank) return -1
    }
    return 0
}
function hand_strength(    hand, card2count, c2c) {
    for (i = 1; i <= 5; i++) # count occurrences of each card
        card2count[substr(hand,i,1)] += 1
    for (i = 1; i <= 13; i++) # for all possible cards
        if (ARRCARDS[i] in card2count) # if in card in card2count
            c2c[card2count[ARRCARDS[i]]] += 1 # add count
    strength = -1
    if (5 in c2c)                            strength = 6 # five of a kind
    if (4 in c2c)                            strength = 5 # four of a kind
    if (3 in c2c && 2 in c2c)                strength = 4 # full house
    if (3 in c2c && 1 in c2c && c2c[1] == 2) strength = 3 # three of a kind
    if (2 in c2c && 1 in c2c && c2c[1] == 1) strength = 2 # two pair
    if (2 in c2c && 1 in c2c && c2c[1] == 3) strength = 1 # one pair
    if (1 in c2c && c2c[1] == 5)             strength = 0 # high card
    return strength
}
BEGIN { CARDS = "A K Q J T 9 8 7 6 5 4 3 2"; split(CARDS, ARRCARDS) }
      { hand2bid[$1] = $2 }

  END {
      PROCINFO["sorted_in"] = "compare_hands"
      for (hand in hand2bid)
          winnings += hand2bid[hand] * ++w
      print winnings
  }
