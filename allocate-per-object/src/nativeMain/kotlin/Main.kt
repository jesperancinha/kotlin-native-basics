import kotlin.time.measureTime

class TestObject(val id: Int, val data: ByteArray)

fun main() {
    val objects = mutableListOf<TestObject>()


    val duration =  measureTime {
        repeat(100_000) {
            objects.add(TestObject(it, ByteArray(1024)))
        }
    }

    println("Allocated 100,000 objects in $duration ms")

    readlnOrNull()
}