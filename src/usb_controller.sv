module usb_controller (
    input logic clk,
    nRST,
    input logic keyReady,
    input logic [7:0] savedByte,

    input  logic DminusIn,
    DplusIn,
    output logic DminusOut,
    DplusOut
);
  typedef enum logic [4:0] {  // adjust size as states get added
    IDLE,

    RECEIVING_SYNC,
    RECEIVING_PID,
    RECEIVING_CRC5,
    RECEIVING_ADDRESS,
    RECEIVING_ENDPOINT,
    RECEIVING_CRC,
    RECEIVING_EOP,

    RECEIVING_DATA,
    SENDING_CRC16,

    INTERMEDIATE,

    SENDING_SYNC,
    SENDING_PID,
    SENDING_CRC5,
    SENDING_ADDRESS,
    SENDING_ENDPOINT,
    SENDING_CRC,
    SENDING_EOP,

    SENDING_DATA,
    SENDING_CRC16
  } phase_e;

  logic DminusInInter;
  logic interDplusIN;

  logic DminusInSynced;  // the ONE that should be used
  logic DplusInSynced;  // the ONE that should be used

  phase_e currentPhase, nextPhase;

  logic [7:0] bitIndex, n_bitIndex;  // current bit index into the packet
  logic [7:0] clockCount, n_clockCount;  // saves how many clock cycles are used per bit

  always_ff @(posedge clk, negedge nRST) begin : Synchronizer
    if (~nRST) begin
      DminusInInter  <= 1;  // set it to 1 in so it syncs with low speed default.
      interDplusIN   <= 0;
      DminusInSynced <= 1;
      DplusInSynced  <= 0;
    end else begin
      interDplusIN   <= DplusIn;
      DminusInInter  <= DminusIn;
      DminusInSynced <= DminusInInter;
      DplusInSynced  <= interDplusIN;
    end
  end

  always_comb begin : StateMachine
    case (currentPhase)

      IDLE: begin
        if (DminusInSynced == 0) begin
          nextPhase = RECEIVING_SYNC;
          nextExpectedDplus = 1;
        end
      end
      RECEIVING_SYNC: begin


      end
      RECEIVING_PID: begin

      end
      RECEIVING_CRC5: begin

      end
      RECEIVING_ADDRESS: begin

      end
      RECEIVING_ENDPOINT: begin

      end
      RECEIVING_CRC: begin

      end
      RECEIVING_EOP: begin

      end
      RECEIVING_DATA: begin

      end
      SENDING_CRC16: begin

      end
      INTERMEDIATE: begin

      end
      SENDING_SYNC: begin

      end
      SENDING_PID: begin

      end
      SENDING_CRC5: begin

      end
      SENDING_ADDRESS: begin

      end
      SENDING_ENDPOINT: begin

      end
      SENDING_CRC: begin

      end
      SENDING_EOP: begin

      end
      SENDING_DATA: begin

      end
      SENDING_CRC1: begin

      end
      default: begin

      end
    endcase
  end





endmodule
