// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SpaAppointment {

    struct Appointment {
        uint256 treatmentId;
        address patient;
        uint256 timestamp;
    }

    struct Feedback {
        uint256 treatmentId;
        uint8 rating;
        string comment;
    }

    mapping(uint256 => uint256) public treatmentBookings;
    mapping(address => Appointment) public appointments;
    mapping(uint256 => Feedback[]) public feedbacks;

    event AppointmentBooked(uint256 treatmentId, address indexed patient);
    event FeedbackSubmitted(uint256 treatmentId, uint8 rating, string comment);

    function bookAppointment(uint256 _treatmentId) external {
        // Logic to book an appointment
        treatmentBookings[_treatmentId]++;
        appointments[msg.sender] = Appointment(_treatmentId, msg.sender, block.timestamp);
        emit AppointmentBooked(_treatmentId, msg.sender);
    }

    function submitFeedback(uint256 _treatmentId, uint8 _rating, string calldata _comment) external {
        // Logic to submit feedback
        feedbacks[_treatmentId].push(Feedback(_treatmentId, _rating, _comment));
        emit FeedbackSubmitted(_treatmentId, _rating, _comment);
    }

    function getFeedback(uint256 _treatmentId) external view returns (Feedback[] memory) {
        return feedbacks[_treatmentId];
    }
}

//contract address	0x06b170ecfa12ec035f139ba80e76a9ca9b896069



