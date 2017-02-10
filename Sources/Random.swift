#if os(Linux)
    public func arc4random() -> UInt32 {
        var result: UInt32 = 0
        arc4random_buf(&result, MemoryLayout<UInt32>.size)
        return result
    }

    public func arc4random_uniform(_ upperBound: UInt32) -> UInt32 {
        return arc4random() % upperBound
    }

    public func arc4random_buf(_ buffer: UnsafeMutableRawPointer, _ count: Int) {
        let descriptor = open("/dev/urandom", O_RDONLY)
        precondition(descriptor >= 1, "/dev/urandom is unavailable")
        let result = read(descriptor, buffer, count)
        close(descriptor)
        precondition(result == count, "read less than expected")
    }
#endif
