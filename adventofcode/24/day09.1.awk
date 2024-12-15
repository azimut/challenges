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
}
END {
    last_seen = disk_size - 1
    for (i = 1; i <= disk_size; i++) {
        if (i % 1000 == 0) print i, "of", disk_size
        if (disk_map[i] == ".") {
            for (j = last_seen; j > i; j--) {
                if (disk_map[j] != ".") {
                    tmp = disk_map[i]
                    disk_map[i] = disk_map[j]
                    disk_map[j] = tmp
                    last_seen = j
                    break
                }
            }
        }
        if (disk_map[i] != ".") {
            checksum += (i-1) * int(disk_map[i])
        }
    }
    print checksum
}
