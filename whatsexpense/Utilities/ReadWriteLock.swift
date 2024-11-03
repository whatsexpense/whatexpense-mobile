import Foundation

final public class ReadWriteLock {
    /**
     rwlock has the same problem with UnfairLock!
     */
    private var _lock: UnsafeMutablePointer<pthread_rwlock_t>

    public init() {
        _lock = UnsafeMutablePointer<pthread_rwlock_t>.allocate(capacity: 1)
        pthread_rwlock_init(_lock, nil)
    }

    deinit {
        _lock.deallocate()
    }

    public func locked<T>(_ body: () throws -> T) rethrows -> T {
        pthread_rwlock_rdlock(_lock)
        defer {
            pthread_rwlock_unlock(_lock)
        }
        return try body()
    }


    public func acquireReadLock<R>(_ action: () throws -> R) rethrows -> R {
        pthread_rwlock_rdlock(_lock)
        defer { pthread_rwlock_unlock(_lock) }

        return try action()
    }

    public func acquireWriteLock<R>(_ action: () throws -> R) rethrows -> R {
        pthread_rwlock_wrlock(_lock)
        defer { pthread_rwlock_unlock(_lock) }

        return try action()
    }

    public func attemptAcquireReadLock<R>(_ action: (Bool) throws -> R) rethrows -> R {
        let result: R

        if pthread_rwlock_tryrdlock(_lock) == 0 {
            defer { pthread_rwlock_unlock(_lock) }
            result = try action(true)
        } else {
            result = try action(false)
        }

        return result
    }

    public func attemptAcquireWriteLock<R>(_ action: (Bool) throws -> R) rethrows -> R {
        let result: R

        if pthread_rwlock_trywrlock(_lock) == 0 {
            defer { pthread_rwlock_unlock(_lock) }
            result = try action(true)
        } else {
            result = try action(false)
        }

        return result
    }
}
