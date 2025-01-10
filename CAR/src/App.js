import { useState } from "react";
import "./App.css";
import BarChart from "./components/BarChart";
import LineChart from "./components/LineChart";
import PieChart from "./components/PieChart";
import { UserData } from "./Data";

function App() {
  const [userData, setUserData] = useState({
    labels: UserData.map((data) => data.year),
    datasets: [
      {
        label: "Users Gained",
        data: UserData.map((data) => data.userGain),
        backgroundColor: [
          "rgba(71,12,152,10)",
          "#ecf0f8",
          "#50AF55",
          "#f3ba8f",
          "#2a71d8",
        ],
        borderColor: "black",
        borderWidth: 2,
      },
    ],
});



  return (
    <div className="App">
      <div style={{ width: 500 }}>
        <BarChart chartData={userData} />
      </div>
      <div style={{ width: 700 }}>
        <LineChart chartData={userData} />
      </div>
      <div style={{ width: 500 }}>
        <PieChart chartData={userData} />
      </div>
    </div>
  );
}

export default App;
