array_of_hashes = []
array_of_hashes << {entry: "waterloo"}
# array_of_hashes << {entry: "waterloo", exit: "king's cross"}
p array_of_hashes
array_of_hashes.last.merge!({exit: "king's cross"})
p array_of_hashes