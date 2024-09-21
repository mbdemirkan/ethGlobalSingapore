import { DiveLog as DiveLogEvent } from "../generated/Contract/Contract"
import { DiveLog } from "../generated/schema"

export function handleDiveLog(event: DiveLogEvent): void {
  let entity = new DiveLog(
    event.transaction.hash.concatI32(event.logIndex.toI32())
  )
  entity.diver = event.params.diver
  entity.newDiveCount = event.params.newDiveCount

  entity.blockNumber = event.block.number
  entity.blockTimestamp = event.block.timestamp
  entity.transactionHash = event.transaction.hash

  entity.save()
}
