BEGIN {
    FS = ","; PROCINFO["sorted_in"] = "@val_num_desc"
    for (;i < split("eggs,peanuts,shellfish,strawberries,tomatoes,chocolate,pollen,cats", items, ",");)
        item2score[items[++i]] = 2^i
}

/list/        { print allergies($1) }
/allergic_to/ { print index(allergies($1), $3) == 0 ? "false" : "true" }

function allergies(current_score,    result, out) {
    closest_idx = int(log(current_score)/log(2))+1
    while (current_score > 256) {
        current_score -= 2^(closest_idx-1)
        closest_idx = int(log(current_score)/log(2))+1
    }
    for (item in item2score) {
        if (item2score[item] == 2^(closest_idx-1)) {
            result[++r] = item
            current_score -= 2^(closest_idx-1)
        }
        if (item2score[item] < 2^(closest_idx-1)) {
            current_score -= 2^(closest_idx-1)
        }
        closest_idx = int(log(current_score)/log(2))+1
    }
    for (i = length(result); i > 0; i--)
        out = out sprintf(latch++ ? ",%s" : "%s", result[i])
    return out
}
