# incomplete: works only with test input file, not with full input
BEGIN { FS="" }
{
    file_id = 0
    disk_size = 1
    for (i = 1; i <= NF; i++) {
        is_file_block = i % 2 != 0
        block_size = $i
        block_data = is_file_block ? file_id : "."
        for (j = disk_size; j < disk_size + block_size; j++) {
            disk_map[j] = block_data
        }
        disk_size += block_size
        if (is_file_block) file_id++
    }
    disk_size--
}
# 5653027521320 too low
# 6420913947251 too high
END { # 2858
    # print_disk()
    right_pointer = disk_size
    print "disk_size = "disk_size
    file_id = 999999999999
    while (right_pointer > 0) {
        for (file_end = right_pointer; file_end > 0; file_end--) {
            if (file_end in disk_map && disk_map[file_end] != "." && disk_map[file_end] < file_id) {
                file_id = disk_map[file_end]
                for (file_start = file_end; file_start > 0; file_start--) {
                    if (file_start in disk_map && disk_map[file_start] != file_id) {
                        file_start++
                        file_size = file_end - file_start + 1
                        break
                    }
                }
                break
            }
        }
        right_pointer = file_end - file_size

        # print file_start, file_end, file_size, disk_map[file_start], disk_map[file_end]
        gap_size = -1
        left_pointer = gap_end = gap_start = 1
        found = 0
        while (file_size > gap_size &&
               gap_start < file_start &&
               gap_start <= gap_end)  {
            for (gap_start = left_pointer; gap_start < file_start; gap_start++) {
                if (gap_start in disk_map && disk_map[gap_start] == ".") {
                    for (gap_end = gap_start; gap_end < file_start; gap_end++) {
                        if (gap_end in disk_map && disk_map[gap_end] != ".") {
                            gap_end--
                            gap_size = gap_end - gap_start + 1
                            found = 1
                            break
                        }
                    }
                    break
                }
            }
            if (!found) break
            left_pointer = gap_start + gap_size
        }
        if (found && file_size <= gap_size) {
            for (i = 0; i < file_size; i++) {
                disk_map[gap_start+i] = disk_map[file_start+i]
                disk_map[file_start+i] = "."
            }
        }
    }
    save_map()
    save_map_length()
    print_disk_context(6,5)
    print compute_checksum()
}
function save_map(    i) {
    for (i = 1; i <= disk_size; i++) {
        printf "[%s]", disk_map[i] > "disk_map.txt"
    }
}
function save_map_length(    i, file_id, file_size) {
    system("rm -f file.txt")
    for (i = 1; i <= disk_size; i++) {
        block = disk_map[i]
        if (block == ".")
            printf "[.]" >> "file.txt"
        else {
            file_id = block
            file_size = 0
            for (j = i; j <= disk_size; j++) {
                if (disk_map[j] != file_id)
                    break
                file_size++
            }
            printf "[%d]", file_size >> "file.txt"
            i = j - 1
        }
    }
}

function compute_checksum(    i, checksum) {
    print "computing checksum..."
    for (i = 1; i <= disk_size; i++)
        checksum += (i-1) * int(disk_map[i])
    return checksum
}
function print_disk(    i) {
    for (i = 1; i <= disk_size; i++)
        printf disk_map[i]
    print ""
}
function print_disk_context(    around, context, i) {
    for (i = around - context; i <= around + context; i++)
        printf "[%s]", disk_map[i]
    print ""
}
function first_empty(    j) {
    for (j = 1; j <= disk_size; j++)
        if (disk_map[j] == ".")
            return j
    return "?"
}
function get_diskmap(x) {
    return (x in disk_map) ? disk_map[x] : "?"
}
function equal_diskmap(    x,y) {
    return (x in diskmap) && (disk_map[x] == y)
}
