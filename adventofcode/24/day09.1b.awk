# alternative solution (more clear?)
BEGIN { FS="" }
{ # same parsing
    is_file_block = 1
    file_id = 0
    disk_size = 1
    for (i = 1; i <= NF; i++) {
        block_size = $i
        block_data = is_file_block ? file_id : "."
        for (j = disk_size; j < disk_size + block_size; j++) {
            disk_map[j] = block_data
        }
        disk_size += block_size
        if (is_file_block) file_id++
        is_file_block = is_file_block ? 0 : 1
    }
    disk_size--
}
END {
    # print_disk()
    free_slot = 1
    file_slot = disk_size
    while (!quit) {
        free_slot = find_free_slot(free_slot)
        file_slot = find_file_slot(file_slot)
        if (!free_slot) quit = 1
        if (!file_slot) quit = 1
        if (free_slot > file_slot) {
            quit = 1
            break
        }
        disk_map[free_slot] = disk_map[file_slot]
        disk_map[file_slot] = "."
        # print_disk()
    }
    print compute_checksum()
}
function compute_checksum() {
    for (i = 1; i <= disk_size; i++)
        checksum += (i-1) * disk_map[i]
    return checksum
}
function find_file_slot(right_start,    i) {
    for (i = right_start; i > 0; i--)
        if (disk_map[i] != ".")
            return i
    return 0
}
function find_free_slot(left_start,    i) {
    for (i = left_start; i <= disk_size; i++)
        if (disk_map[i] == ".")
            return i
    return 0
}
function print_disk(    i) {
    for (i = 1; i <= disk_size; i++)
        printf disk_map[i]
    print ""
}
