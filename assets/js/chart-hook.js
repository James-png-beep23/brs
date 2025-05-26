// Import Highcharts
import Highcharts from "highcharts"

export const RevenueChart = {
  dataset() { return JSON.parse(this.el.dataset.totalRevenue); },
  mounted() {
    // Access the element
    const ctx = this.el;
    const chartData = this.dataset();
    // Render the Highcharts area graph
    Highcharts.chart(ctx, {
      chart: {
        type: 'areaspline',
        backgroundColor: null
      },
      title: {
        text: '',
        align: 'left'
      },
      legend: {
        enabled: false
      },
      xAxis: {
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
        min: 0.5,
        max: 11,
        tickInterval: 1,
        maxPadding: 0,
        endOnTick: false,
        startOnTick: false,
        title: {
          text: 'Month',
          style: {
            color: '#475467', // Red color for the title
            fontWeight: 'bold', // Bold weight for the title
          },
          margin: 20 // Padding at the top of the title
        },
        labels: {
          style: {
            color: '#475467' // Custom color for the yAxis labels
          }
        }
      },
      yAxis: {
        title: {
          text: ''
        },
        labels: {
          style: {
            color: '#475467' // Custom color for the yAxis labels
          }
        }
      },
      credits: {
        enabled: false
      },
      plotOptions: {
        areaspline: {
          fillColor: {
            linearGradient: [0, 0, 0, 300],
            stops: [
              [0, 'rgba(33, 123, 222, .3)'],
              [1, 'rgba(36, 122, 217, 0)']
            ]
          },
          marker: {
            enabled: true, // Enable the markers
            fillColor: '#1E6EC8', // Fill color of the markers
            lineColor: '#FFFFFF', // Border color of the markers
            lineWidth: 2 // Width of the marker border
          }
        }
      },
      series: [{
        lineColor: '#1E6EC8',
        name: 'KSH',
        marker: {
          enabled: false
        },
        data: chartData
      }]

    });
  },
  updated() {
    // Handle updates to the chart here
  }
}

export const TaskDistributionChart = {
  dataset() { return JSON.parse(this.el.dataset.taskDistribution); },
  mounted() {
    const ctx = this.el;
    const chartData = this.dataset();
    Highcharts.chart(ctx, {
      chart: {
        plotBackgroundColor: null,
        plotBorderWidth: null,
        plotShadow: false,
        type: 'pie'
      },
      title: {
        text: '',
        align: 'left'
      },
      tooltip: {
        pointFormat: '{series.name}: <b>{point.y}</b>'
      },
      plotOptions: {
        pie: {
          allowPointSelect: true,
          cursor: 'pointer',
          dataLabels: {
            enabled: false
          },
          showInLegend: true,
          borderWidth: 0
        }
      },
      legend: {
        labelFormatter: function () {
          return '<span style="color:#101828;font-weight:600;font-size:20px;">' + this.y + '</span>' +
            '<span style="color:#475467;font-size:14px;font-weight:400;"> ' + this.name + '</span>';
        }
      },
      credits: {
        enabled: false
      },
      series: [{
        name: 'Brands',
        colorByPoint: true,
        data: chartData
      }]
    });
  }
}

export const TaskCompletionChart = {
  dataset() { return JSON.parse(this.el.dataset.taskCompletion); },
  mounted() {
    const ctx = this.el;
    const chartData = this.dataset();
    const completedTasks = 734;
    const totalTasks = completedTasks + 440;
    const completedPercentage = (completedTasks / totalTasks) * 100;
    Highcharts.chart(ctx, {
      chart: {
        plotBackgroundColor: null,
        plotBorderWidth: 0,
        margin: [0, 0, 0, 0],
        plotShadow: false,
        borderRadius: 20
      },
      title: {
        text: '<span style="color:#111827;display:block;font-size:30px;font-weight:700;padding-bottom:20px;line-height:40px">'
          + completedPercentage.toFixed(1)
          + '%</span><br> <span style="color:#111827;display:block;font-size:16px;font-weight: 400;">Tasks Completion Rate</span><br>',
        align: 'center',
        verticalAlign: 'middle',
        y: 70
      },
      credits: {
        enabled: false
      },
      tooltip: {
        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
      },
      accessibility: {
        point: {
          valueSuffix: '%'
        }
      },
      legend: {
        align: 'center',
        verticalAlign: 'bottom',
        layout: 'horizontal',
        labelFormatter: function () {
          // Customize the legend labels to include the task counts
          if (this.name === 'Completed') {
            return '<span style="color:#101828;font-weight:600;font-size:20px;">' + completedTasks + '</span>' +
              '<span style="color:#475467;font-size:14px;font-weight:400;"> ' + this.name + '</span>';
          } else {
            return '<span style="color:#101828;font-weight:600;font-size:20px;">' + (totalTasks - completedTasks) + '</span>' +
              '<span style="color:#475467;font-size:14px;font-weight:400;"> ' + this.name + '</span>';
          }
        }
      },
      plotOptions: {
        pie: {
          dataLabels: {
            enabled: false,
            distance: -50,
            style: {
              fontWeight: 'bold',
              color: 'white'
            }
          },
          startAngle: -90,
          endAngle: 90,
          center: ['50%', '75%'],
          size: '110%',
          borderWidth: 4,
          borderColor: '#fff',
          showInLegend: true,
          colors: ['#20903C', '#0068FF']
        }
      },
      series: [{
        type: 'pie',
        name: 'Tasks Completion Rate',
        innerSize: '80%',
        data: chartData
      }]
    });

  }
}

export const RegistryTasksChart = {
  dataset() { return JSON.parse(this.el.dataset.registryTasks); },
  mounted() {
    const ctx = this.el;
    const chartData = this.dataset();
    Highcharts.chart(ctx, {
      chart: {
        type: 'column',
      },
      title: {
        text: ''
      },
      subtitle: {
        text: ''
      },
      credits: {
        enabled: false
      },
      legend: {
        enabled: false
      },
      xAxis: {
        lineColor: '#e6e6e6',
        categories: [
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec'
        ],
        crosshair: true
      },
      yAxis: {
        min: 0,
        title: {
          text: ''
        }
      },
      tooltip: {
        headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
        pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
          '<td style="padding:0"><b>{point.y:.1f}</b></td></tr>',
        footerFormat: '</table>',
        shared: true,
        useHTML: true
      },
      plotOptions: {
        column: {
          pointPadding: 0.2,
          borderWidth: 0
        }
      },
      series: [{
        name: 'KSH',
        data: chartData,
        color: '#2A80DF'

      }]
    });

  }
}

export const RegistryApplicationsChart = {
  dataset() { return JSON.parse(this.el.dataset.registryApplications); },
  mounted() {
    const ctx = this.el;
    const chartData = this.dataset();
    Highcharts.chart(ctx, {
      chart: {
        backgroundColor: null,
        type: 'column',
        spacingTop: 0,
        height: '500'
      },
      exporting: {
        enabled: false
      },
      credits: {
        enabled: false //get rid of highcharts credit
      },
      title: {
        text: '',
        style: {
          display: 'none'
        }
      },
      xAxis: {
        tickWidth: 0,
        lineWidth: 0,
        categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
      },
      yAxis: {
        tickInterval: 2,
        min: 0,
        max: 20,
        lineWidth: 0,
        align: 'left',
        labels: {
          enabled: false // Disable labels on the y-axis
        },
        stackLabels: {
          enabled: false,
        },
        title: {
          style: {
            display: 'none'
          }
        }
      },
      navigation: {
        enabled: false
      },
      legend: {
        enabled: true
      },
      tooltip: {
        enabled: true
      },
      plotOptions: {
        series: {
          events: {
            legendItemClick: function () {
              var visibility = this.visible ? 'visible' : 'hidden';

              if (!alert('Info about Fees?')) {
                return false;
              }
            }
          },
          minPointLength: 3,
          states: {
            hover: {
              enabled: false
            }
          }
        },
        column: {
          stacking: 'normal',
          dataLabels: false, //bar numbers off
          borderWidth: 0,
        },
      },
      colors: ['#7ACEA8',
        '#55c8e8',
        '#1666af',
        '#37c47d',
        '#49882c',
        '#23b1b1',
        '#84d3a7',
        '#006b69',
        '#7db29c',
        '#7db29c',
        '#72b325'
      ],
      series: chartData

    });

  }
}