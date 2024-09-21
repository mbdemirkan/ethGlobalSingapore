import {
  assert,
  describe,
  test,
  clearStore,
  beforeAll,
  afterAll
} from "matchstick-as/assembly/index"
import { Address, BigInt } from "@graphprotocol/graph-ts"
import { DiveLog } from "../generated/schema"
import { DiveLog as DiveLogEvent } from "../generated/Contract/Contract"
import { handleDiveLog } from "../src/contract"
import { createDiveLogEvent } from "./contract-utils"

// Tests structure (matchstick-as >=0.5.0)
// https://thegraph.com/docs/en/developer/matchstick/#tests-structure-0-5-0

describe("Describe entity assertions", () => {
  beforeAll(() => {
    let diver = Address.fromString("0x0000000000000000000000000000000000000001")
    let newDiveCount = BigInt.fromI32(234)
    let newDiveLogEvent = createDiveLogEvent(diver, newDiveCount)
    handleDiveLog(newDiveLogEvent)
  })

  afterAll(() => {
    clearStore()
  })

  // For more test scenarios, see:
  // https://thegraph.com/docs/en/developer/matchstick/#write-a-unit-test

  test("DiveLog created and stored", () => {
    assert.entityCount("DiveLog", 1)

    // 0xa16081f360e3847006db660bae1c6d1b2e17ec2a is the default address used in newMockEvent() function
    assert.fieldEquals(
      "DiveLog",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "diver",
      "0x0000000000000000000000000000000000000001"
    )
    assert.fieldEquals(
      "DiveLog",
      "0xa16081f360e3847006db660bae1c6d1b2e17ec2a-1",
      "newDiveCount",
      "234"
    )

    // More assert options:
    // https://thegraph.com/docs/en/developer/matchstick/#asserts
  })
})
