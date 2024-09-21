import { newMockEvent } from "matchstick-as"
import { ethereum, Address, BigInt } from "@graphprotocol/graph-ts"
import { DiveLog } from "../generated/Contract/Contract"

export function createDiveLogEvent(
  diver: Address,
  newDiveCount: BigInt
): DiveLog {
  let diveLogEvent = changetype<DiveLog>(newMockEvent())

  diveLogEvent.parameters = new Array()

  diveLogEvent.parameters.push(
    new ethereum.EventParam("diver", ethereum.Value.fromAddress(diver))
  )
  diveLogEvent.parameters.push(
    new ethereum.EventParam(
      "newDiveCount",
      ethereum.Value.fromUnsignedBigInt(newDiveCount)
    )
  )

  return diveLogEvent
}
