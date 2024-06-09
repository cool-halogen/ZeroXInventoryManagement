import React, { useState } from 'react';
import { DndProvider, useDrag, useDrop } from 'react-dnd';
import { HTML5Backend } from 'react-dnd-html5-backend';
import './App.css';

const ChargingStation = ({ id, color, trucks, onDrop }) => {
  const [{ isOver }, drop] = useDrop(() => ({
    accept: 'truck',
    drop: (item) => onDrop(item.id, id),
    collect: (monitor) => ({
      isOver: !!monitor.isOver(),
    }),
  }));

  return (
    <div ref={drop} className={`charging-station ${isOver ? 'highlighted' : ''}`} style={{ backgroundColor: color }}>
      <h3>Station {id}</h3>
      <div className="trucks">
        {trucks.map((truck) => (
          <Truck key={truck.id} id={truck.id} number={truck.number} />
        ))}
      </div>
    </div>
  );
};

const Truck = ({ id, number }) => {
  const [{ isDragging }, drag] = useDrag(() => ({
    type: 'truck',
    item: { id },
    collect: (monitor) => ({
      isDragging: !!monitor.isDragging(),
    }),
  }));

  return (
    <span ref={drag} className={`truck ${isDragging ? 'dragging' : ''}`}>
      <i className="fas fa-truck"></i>
      <span>{number}</span>
    </span>
  );
};

const App = () => {
  const [stations, setStations] = useState(
    Array.from({ length: 10 }, (_, i) => ({
      id: i + 1,
      color: `#${Math.floor(Math.random() * 16777215).toString(16)}`, // Generating random color for each station
      trucks: [],
    }))
  );
  const [trucks, setTrucks] = useState(Array.from({ length: 48 }, (_, i) => ({ id: i + 1, number: i + 1 })));

const handleDrop = (truckId, stationId) => {
  setStations((prevStations) => {
    // Check if the truck is already assigned to any station
    const isAssigned = prevStations.some(station => station.trucks.some(truck => truck.id === truckId));
    if (isAssigned) {
      // If the truck is assigned, filter it out from the list of available trucks
      setTrucks(prevTrucks => prevTrucks.filter(truck => truck.id !== truckId));
      return prevStations;
    }

    // If the truck is not assigned, proceed with assigning it to the station
    const updatedStations = prevStations.map((station) => {
      if (station.id === stationId) {
        // Check if the truckId already exists in the list of trucks for this station
        if (!station.trucks.some((truck) => truck.id === truckId)) {
          return {
            ...station,
            trucks: [...station.trucks, { id: truckId, number: truckId }],
          };
        }
      }
      return station;
    });
    return updatedStations;
  });
};

  return (
    <DndProvider backend={HTML5Backend}>
      <div className="App">
        <h1>Truck Charging Station Assignment</h1>
        <div className="charging-stations">
          {stations.map((station) => (
            <ChargingStation
              key={station.id}
              id={station.id}
              color={station.color}
              trucks={station.trucks}
              onDrop={handleDrop}
            />
          ))}
        </div>
        <div className="trucks">
          <h2>Trucks</h2>
          {trucks.map((truck) => (
            <Truck key={truck.id} id={truck.id} number={truck.number} />
          ))}
        </div>
      </div>
    </DndProvider>
  );
};

export default App;
