// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SpaAppointment {

    // Structure to store details of an appointment
    struct Appointment {
        uint256 treatmentId;  // ID of the treatment the appointment is for
        address patient;      // Address of the patient making the appointment
        uint256 timestamp;    // Timestamp of when the appointment was made
    }

    // Structure to store feedback information
    struct Feedback {
        uint256 treatmentId;  // ID of the treatment the feedback is for
        uint8 rating;         // Rating given by the patient (e.g., 1-5)
        string comment;       // Comment provided by the patient
    }

    // Mapping from treatment ID to the number of bookings for that treatment
    mapping(uint256 => uint256) public treatmentBookings;

    // Mapping from patient address to their appointment details
    mapping(address => Appointment) public appointments;

    // Mapping from treatment ID to an array of feedbacks given for that treatment
    mapping(uint256 => Feedback[]) public feedbacks;

    // Event emitted when an appointment is booked
    event AppointmentBooked(uint256 treatmentId, address indexed patient);

    // Event emitted when feedback is submitted
    event FeedbackSubmitted(uint256 treatmentId, uint8 rating, string comment);

    /**
     * @dev Books an appointment for a specified treatment.
     * @param _treatmentId The ID of the treatment the appointment is for.
     * This function increments the number of bookings for the treatment and
     * stores the patient's appointment details in the `appointments` mapping.
     * It also emits the `AppointmentBooked` event.
     */
    function bookAppointment(uint256 _treatmentId) external {
        // Increment the number of bookings for the specified treatment
        treatmentBookings[_treatmentId]++;

        // Store the appointment details for the caller (patient)
        appointments[msg.sender] = Appointment(_treatmentId, msg.sender, block.timestamp);

        // Emit an event to signal that an appointment has been booked
        emit AppointmentBooked(_treatmentId, msg.sender);
    }

    /**
     * @dev Submits feedback for a specified treatment.
     * @param _treatmentId The ID of the treatment the feedback is for.
     * @param _rating The rating given by the patient (e.g., 1-5).
     * @param _comment The comment provided by the patient.
     * This function adds the feedback to the array of feedbacks for the specified treatment
     * and emits the `FeedbackSubmitted` event.
     */
    function submitFeedback(uint256 _treatmentId, uint8 _rating, string calldata _comment) external {
        // Add the feedback to the list of feedbacks for the specified treatment
        feedbacks[_treatmentId].push(Feedback(_treatmentId, _rating, _comment));

        // Emit an event to signal that feedback has been submitted
        emit FeedbackSubmitted(_treatmentId, _rating, _comment);
    }

    /**
     * @dev Retrieves feedback for a specified treatment.
     * @param _treatmentId The ID of the treatment for which feedback is requested.
     * @return An array of `Feedback` structures containing all feedback for the treatment.
     * This function allows users to view all feedbacks submitted for a specific treatment.
     */
    function getFeedback(uint256 _treatmentId) external view returns (Feedback[] memory) {
        // Return the array of feedbacks for the specified treatment
        return feedbacks[_treatmentId];
    }
}


//contract address	0x06b170ecfa12ec035f139ba80e76a9ca9b896069



