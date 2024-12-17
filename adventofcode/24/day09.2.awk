BEGIN { FS="" }
{
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
# TODO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1111
# FILE_IDs bigger than 9 occupy more than 1 block in disk
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
# 5653027521320 too low
END { # 2858 - 94957 too low
    # print_disk()
    right_pointer = disk_size
    print "disk_size = "disk_size
    while (right_pointer > 0) {
        for (file_end = right_pointer; file_end > 0; file_end--) {
            if (disk_map[file_end] != ".") {
                file_id = disk_map[file_end]
                for (file_start = file_end; file_start > 0; file_start--) {
                    if (disk_map[file_start] != file_id) {
                        file_start++
                        file_size = file_end - file_start + 1
                        break
                    }
                }
                break
            }
        }
        right_pointer = file_end - file_size
        if (file_id in fragmented) continue
        fragmented[file_id] = 1

        # print file_start, file_end, file_size, disk_map[file_start], disk_map[file_end]
        gap_size = -1
        left_pointer = gap_start = 1
        while (file_size > gap_size && gap_start < file_start)  {
            for (gap_start = left_pointer; gap_start < file_start; gap_start++) {
                if (disk_map[gap_start] == ".") {
                    for (gap_end = gap_start; gap_end < file_start; gap_end++) {
                        if (disk_map[gap_end] != ".") {
                            gap_end--
                            break
                        }
                    }
                    break
                }
            }
            gap_size = gap_end - gap_start + 1
            if (file_size <= gap_size) {
                # print "gap =", gap_start, gap_end, gap_size, "file_id =", disk_map[file_start]
                for (i = 0; i < file_size; i++) {
                    disk_map[gap_start+i] = disk_map[file_start+i]
                    disk_map[file_start+i] = "."
                }
            } else {
                if (disk_map[gap_start] != ".") {
                    print "gap =", gap_start, gap_end, gap_size, file_size, "file_id =", disk_map[file_start]
                    print first_empty()
                    print_disk_context(gap_start)
                    break
                }
                left_pointer = gap_start + gap_size
            }
        }
        # print_disk()
    }
    print compute_checksum()
}
function compute_checksum() {
    printf "computing checksum..."
    for (i = 1; i <= disk_size; i++)
        checksum += (i-1) * int(disk_map[i])
    return checksum
}
function print_disk(    i) {
    for (i = 1; i <= disk_size; i++)
        printf disk_map[i]
    print ""
}
function print_disk_context(    context, i) {
    for (i = context - 5; i <= context + 5; i++)
        printf "[%d]", disk_map[i]
    print ""
}
function first_empty(    j) {
    for (j = 1; j <= disk_size; j++)
        if (disk_map[j] == ".")
            return j
    return "?"
}
