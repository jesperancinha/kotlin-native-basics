import kotlin.native.runtime.NativeRuntimeApi
import kotlin.time.TimeSource

@OptIn(NativeRuntimeApi::class)
fun main() {
    println("Starting memory stress test...")

    val totalRounds = 100_000
    val objectsPerRound = 10_000
    val sizes = List(totalRounds * objectsPerRound) {
        64 + (it % 192) // Generates repeating pattern between 64 and 256
    }
    val allocations = mutableListOf<ByteArray>()
    val timeCounter = TimeSource.Monotonic.markNow()
    for (i in 1..totalRounds) {
        repeat(objectsPerRound) {
            allocations.add(ByteArray(sizes[i]))
        }


        if (i % 10_000 == 0) {
            println("Round $i - GC suggestion and shrinking list.")
            // Clear and force a GC hint
            allocations.clear()
            kotlin.native.runtime.GC.collect()
        }
    }

    println("Total time: ${timeCounter.elapsedNow().inWholeMilliseconds} ms")
}
