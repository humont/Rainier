//
//  ThreadSupervisor.swift
//  FrontierCore
//
//  Created by Brent Simmons on 4/23/17.
//  Copyright © 2017 Ranchero Software. All rights reserved.
//

import Foundation

// When Frontier creates a thread, it should use ThreadSupervisor, which counts and manages threads. The thread verbs need ThreadSupervisor.


public struct ThreadSupervisor {
	
	public static let mainThreadID = 0
	public static let unknownThreadID = -1

	public static var numberOfThreads: Int {
		get {
			return threads.count + 1 // Add one for main thread
		}
	}
	
	private static var threads = [Int: ManagedThread]()
	private static let lock = NSLock()
	private static var incrementingThreadID = 1
	
	public static func createAndRunThread(block: @escaping VoidBlock) {
		
		let thread = ManagedThread(block: block)
		thread.name = "Frontier Thread"
		
		lock.lock()
		thread.identifier = incrementingThreadID
		incrementingThreadID = incrementingThreadID + 1
		threads[thread.identifier] = thread
		lock.unlock()
		
		thread.start()
	}
	
	public static func currentThreadID() -> Int {
		
		if Thread.isMainThread {
			return mainThreadID
		}
		
		if let thread = Thread.current as? ManagedThread {
			return thread.identifier
		}
		return unknownThreadID
	}
	
	// MARK: Thread callback
	
	static func threadDidComplete(identifier: Int) {
		
		lock.lock()
		threads[identifier] = nil
		lock.unlock()
	}
}
